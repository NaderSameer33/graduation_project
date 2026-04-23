
import 'package:etmaen/notifaction/widgets/notifaction_header.dart';
import 'package:etmaen/notifaction/widgets/notifaction_list_view.dart';
import 'package:etmaen/notifaction/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificaionView extends StatelessWidget {
  const NotificaionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              NotifactionHeader(),
              SizedBox(
                height: 20.h,
              ),
              NotificationItem(
                title: 'اليوم',
              ),

              NotifactionListView(),
              SizedBox(
                height: 21.h,
              ),
              NotificationItem(title: 'هذا الاسبوع'),
              SizedBox(
                height: 8.h,
              ),
              NotifactionListView(),
            ],
          ),
        ),
      ),
    );
  }
}
