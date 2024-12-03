import 'package:convo_sphere/core/theme.dart';
import 'package:flutter/material.dart';

import 'feature/message/presentation/ui/messages_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConvoSphere',
      theme: AppTheme.darkTheme,
      home: const MessagesPage(),
    );
  }
}
