import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTicket extends StatelessWidget {
  const CreateTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          const Text('Email or Phone Number'),
          const SizedBox(
            height: 8,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Subject'),
          const SizedBox(
            height: 8,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Message'),
          const SizedBox(
            height: 8,
          ),
          const TextField(
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CupertinoButton(
            color: Colors.green,
            child: const Text('Create Ticket'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
