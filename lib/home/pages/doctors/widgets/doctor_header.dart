import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/home/pages/doctors/favorites/favorites_screen.dart';
import 'package:etmaen/home/pages/doctors/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({super.key, required this.doctors});
   final List <DoctorModel> doctors ; 
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoritesScreen(
                            favoriteDoctors: doctors 
                                .where((d) => d.isFavorite)
                                .toList(),
                          ),
                        ),
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Title — appears on RIGHT in RTL
                    const Text(
                      'فريق من الخبراء جاهز لدعمك',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ); 
  }
}