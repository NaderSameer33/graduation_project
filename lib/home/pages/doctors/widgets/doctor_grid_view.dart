import 'package:etmaen/home/pages/doctors/doctor_detail_screen.dart';
import 'package:etmaen/home/pages/doctors/models/doctor_model.dart';
import 'package:etmaen/home/pages/doctors/widgets/doctor_card.dart';
import 'package:flutter/cupertino.dart';

class DoctorGridView extends StatelessWidget {
  const DoctorGridView({
    super.key,
    required this.filtered,
    required this.toogleFaourite,
  });
  final List<DoctorModel> filtered;
  final Function(String id) toogleFaourite;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: filtered.length,
      itemBuilder: (_, i) => DoctorCard(
        doctor: filtered[i],
        onFavoriteToggle: () => toogleFaourite(filtered[i].id),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => DoctorDetailScreen(
              doctorName: filtered[i].name,
              specialty: filtered[i].specialty,
              rating: filtered[i].rating,
              sessionPrice: filtered[i].price,
              experience: filtered[i].experience,
              reviewCount: filtered[i].reviewCount,
              sessionDuration: filtered[i].sessionDuration,
            ),
          ),
        ),
      ),
    );
  }
}
