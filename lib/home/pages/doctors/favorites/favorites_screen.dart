import '../../../../core/ui/app_back.dart';
import '../../../../core/ui/app_style.dart';
import '../models/doctor_model.dart';
import '../widgets/empty_Favourite.dart';
import '../widgets/favourite_card.dart';
import '../widgets/favourite_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/ui/app_color.dart';

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

  @override
  void initState() {
    super.initState();
    _favorites = widget.favoriteDoctors.isNotEmpty
        ? List.from(widget.favoriteDoctors)
        : sampleFavorites();
  }

  void _removeFavorite(String id) {
    setState(() {
      _favorites.removeWhere((d) => d.id == id);
    });
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
                child: _favorites.isEmpty
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
                        itemBuilder: (_, i) {
                          final doc = _favorites[i];
                          return FavDoctorCard(
                            doctor: doc,
                            onRemoveFavorite: () => _removeFavorite(doc.id),
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => DoctorDetailScreen(
                                  doctorName: doc.name,
                                  specialty: doc.specialty,
                                  rating: doc.rating,
                                  sessionPrice: doc.price,
                                  experience: doc.experience,
                                  reviewCount: doc.reviewCount,
                                  sessionDuration: doc.sessionDuration,
                                ),
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
