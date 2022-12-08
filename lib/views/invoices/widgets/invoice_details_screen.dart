import 'package:flutter/material.dart';
import '../../../const/const.dart';

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({super.key});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          backgroundColor: greenColor,
          centerTitle: true,
          title: const Text('Package Details')),
      body: SingleChildScrollView(
          child: Column(
        children: const [
          ListTile(
            title: Text(
              "User Name:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text('Dath'),
          ),
          ListTile(
            title: Text(
              "Advertenties:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text('20'),
          ),
          ListTile(
            title: Text(
              "Actiet:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text('2-12-2022'),
          ),
          ListTile(
            title: Text(
              "Verlopen:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text('1-1-2023'),
          ),
          ListTile(
            title: Text(
              "Amount",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text('SRD 200'),
          ),
        ],
      )),
    );
  }
}
