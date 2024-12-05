import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextPromptWidget extends StatelessWidget {
  const RichTextPromptWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.pressableText,
  });

  final String text, pressableText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: '$text ',
          style: const TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: pressableText,
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            )
          ],
        ),
      ),
    );
  }
}
