import 'package:etmaen/notifaction/widgets/notifaction_list_view_item.dart';
import 'package:flutter/material.dart';

class NotifactionListView extends StatelessWidget {
  const NotifactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.startToEnd,
          key: UniqueKey(),
          child: NotificationListViewItem(),
        ),
      ),
    );
  }
}
