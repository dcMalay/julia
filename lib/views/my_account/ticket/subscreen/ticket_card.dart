import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 95,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ticket Subject'),
              const Text('Ticket Id: #123456'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('20/09/2022'),
                  const SizedBox(
                    width: 90,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    padding: const EdgeInsets.only(left: 25, top: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 95,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ticket Subject'),
              const Text('Ticket Id: #123456'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('20/09/2022'),
                  const SizedBox(
                    width: 90,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    padding: const EdgeInsets.only(left: 25, top: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 95,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ticket Subject'),
              const Text('Ticket Id: #123456'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('20/09/2022'),
                  const SizedBox(
                    width: 90,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    padding: const EdgeInsets.only(left: 25, top: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 95,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ticket Subject'),
              const Text('Ticket Id: #123456'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('20/09/2022'),
                  const SizedBox(
                    width: 90,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    padding: const EdgeInsets.only(left: 25, top: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow,
                    ),
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
