import 'package:convo_sphere/core/utils/date_util.dart';
import 'package:flutter/material.dart';

class MessageTileWidget extends StatelessWidget {
  const MessageTileWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.message,
    required this.time,
    this.onTap,
  });

  final String name, imageUrl, message;
  final DateTime time;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      splashColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        '${DateUtil.dateTimeToTimeFormat(time)}\n${DateUtil.dateTimeToDateFormat(time)}',
        textAlign: TextAlign.right,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
