import '../../../../core/logic/api/api_service.dart';
import '../models/doctor_model.dart';
import '../widgets/empty_Favourite.dart';
import '../widgets/favourite_card.dart';
import '../widgets/favourite_header.dart';
import 'package:flutter/material.dart';

import '../doctor_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, this.favoriteDoctors = const []});

  final List<DoctorModel> favoriteDoctors;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<DoctorModel> _favorites;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    // If doctors were passed in, use them directly
    if (widget.favoriteDoctors.isNotEmpty) {
      setState(() {
        _favorites = List.from(widget.favoriteDoctors);
        _isLoading = false;
      });
      return;
    }

    // Otherwise fetch from API
    final res = await ApiService.authenticatedGet('favorites');
    if (!mounted) return;

    if (res.success && res.asList.isNotEmpty) {
      final list = res.asList;
      setState(() {
        _favorites = list
            .map((e) => DoctorModel.fromJson(e))
            .toList();
        _isLoading = false;
      });
    } else {
      // Fallback to sample favorites
      setState(() {
        _favorites = sampleFavorites();
        _isLoading = false;
      });
    }
  }

  void _removeFavorite(String id) async {
    setState(() {
      _favorites.removeWhere((d) => d.id == id);
    });
    // Call API to remove from favorites
    await ApiService.delete('favorite_toggle', id: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            children: [
              FavouriteHeader(),
              SizedBox(
                height: 16.h,
              ),

              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _favorites.isEmpty
                        ? EmptyFavorites()
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.72,
                                ),
                            itemCount: _favorites.length,
                            itemBuilder: (context, index) {
                              final doctor = _favorites[index];
                              return FavDoctorCard(
                                doctor: doctor,
                                onRemoveFavorite: () => _removeFavorite(doctor.id),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorDetailScreen(doctor: doctor),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
