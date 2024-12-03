import 'package:convo_sphere/core/theme.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
          color: DefaultColors.senderMessage,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
