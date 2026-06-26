import '../core/logic/api/api_service.dart';
import 'widgets/notifaction_header.dart';
import 'widgets/notifaction_list_view_item.dart';
import 'widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificaionView extends StatefulWidget {
  const NotificaionView({super.key});

  @override
  State<NotificaionView> createState() => _NotificaionViewState();
}

class _NotificaionViewState extends State<NotificaionView> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    final res = await ApiService.authenticatedGet('notifications');
    if (res.success && res.asList.isNotEmpty) {
      setState(() {
        _notifications = res.asList;
        _isLoading = false;
      });
    } else {
      // Fallback to sample
      setState(() {
        _notifications = List.generate(
            5,
            (i) => {
                  'title': 'تمرين تنفس جديد',
                  'body': 'ابدأ معنا الأن ',
                  'time': 'منذ دقيقة',
                });
        _isLoading = false;
      });
    }
  }

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
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _notifications.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final notif = _notifications[index];
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: UniqueKey(),
                            child: NotificationListViewItem(
                              title: notif['title'] as String? ??
                                  'تمرين تنفس جديد',
                              body: notif['body'] as String? ??
                                  notif['message'] as String? ??
                                  'ابدأ معنا الأن ',
                              time: notif['time'] as String? ?? 'منذ دقيقة',
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
