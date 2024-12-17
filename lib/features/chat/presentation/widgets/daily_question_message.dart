import 'package:convo_sphere/core/theme.dart';
import 'package:flutter/material.dart';

class DailyQuestionMessageWidget extends StatelessWidget {
  const DailyQuestionMessageWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: DefaultColors.dailyQuestionColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '🧠 Daily Question: \n\n$message',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white70),
        ),
      ),
    );
    ;
  }
}
