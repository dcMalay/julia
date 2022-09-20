import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:julia/views/my_account/ticket/subscreen/create_ticket.dart';
import 'package:julia/views/my_account/ticket/subscreen/ticket.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          centerTitle: true,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          flexibleSpace: Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.airplane_ticket,
                  color: Colors.yellow,
                ),
                Text(
                  'Ticket',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          title: const Text(
            'Ticket',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1.0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.airplane_ticket,
                    color: Colors.yellow,
                    size: 100,
                  ),
                  Text(
                    'Ticket',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorColor: Colors.yellow,
                tabs: [
                  Tab(
                    text: 'My Ticket',
                  ),
                  Tab(
                    text: 'Create Ticket',
                  ),
                ]),
            const Expanded(
              child: TabBarView(
                children: [
                  Ticket(),
                  CreateTicket(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
