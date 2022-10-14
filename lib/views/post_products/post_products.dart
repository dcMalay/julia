// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostProductsView extends StatefulWidget {
  const PostProductsView({super.key});

  @override
  State<PostProductsView> createState() => _PostProductsViewState();
}

class _PostProductsViewState extends State<PostProductsView> {
  //List of items in our dropdown menu
  var issueCategory = [
    'Cars',
    'Bikes',
    'Electroniocs',
    'Fashion',
    'Pets',
    'Mobile',
    'Books',
    'Sports',
    'Others',
  ];
  var location = [
    'Brokopondo',
    'Commewijne',
    'Coronie',
    'Marowijne',
    'Nickerie',
    'Para',
    'Paramaribo',
    'Saramacca',
    'Sipaliwini',
    'Wanica',
  ];
  // Initial Selected Value
  var _dropdownValue;
  var _locationValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Sell Your Products',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Add Title*',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Brand*',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<String>(
                    enableFeedback: true,
                    hint: const Text('Type'),
                    isExpanded: true,
                    value: _dropdownValue,
                    items: issueCategory
                        .map((String item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (String? d) {
                      setState(() {
                        _dropdownValue = d!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Description of what you sell*',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Price',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Photo',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CupertinoButton(
                    color: Colors.green,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.image),
                        Text(
                          'Upload Image',
                        ),
                      ],
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<String>(
                    enableFeedback: true,
                    hint: const Text('Type'),
                    isExpanded: true,
                    value: _locationValue,
                    items: location
                        .map((String item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (String? d) {
                      setState(() {
                        _dropdownValue = d!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Your Name',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  color: Colors.green,
                  child: const Text(
                    'Next One',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
