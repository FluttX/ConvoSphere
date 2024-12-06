import 'package:convo_sphere/core/theme.dart';
import 'package:flutter/material.dart';

class MessageInputWidget extends StatelessWidget {
  const MessageInputWidget({
    super.key,
    required this.controller,
    this.onSendPressed,
  });

  final TextEditingController controller;
  final Function()? onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: onSendPressed,
            icon: const Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
