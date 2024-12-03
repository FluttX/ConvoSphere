import 'package:flutter/material.dart';

class RecentContactWidget extends StatelessWidget {
  const RecentContactWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  final String name, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 5.0),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
