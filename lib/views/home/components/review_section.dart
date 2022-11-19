import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(
              'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png'),
        ),
      ),
    );
  }
}
