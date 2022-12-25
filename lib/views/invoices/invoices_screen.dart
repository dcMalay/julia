import 'package:flutter/material.dart';
import 'package:julia/data/model/package_details_model.dart';
import 'package:julia/data/repository/package_details_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../const/const.dart';

class InVoicesScreen extends StatefulWidget {
  const InVoicesScreen({super.key});

  @override
  State<InVoicesScreen> createState() => _InVoicesScreenState();
}

class _InVoicesScreenState extends State<InVoicesScreen> {
  late Future<List<Package>> packagedetails;
  bool ispackage = true;

  @override
  void initState() {
    setState(() {
      packagedetails = getpackageDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: greenColor,
        centerTitle: true,
        title: const Text('InVoices'),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    setState(() {
                      ispackage = true;
                    });
                  },
                  child: Text("package".tr())),
              PopupMenuItem(
                  onTap: () {
                    setState(() {
                      ispackage = false;
                    });
                  },
                  child: Text("boosts".tr())),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const InvoiceDetailScreen();
            // }));
          },
          child: ispackage
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "package".tr(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    FutureBuilder<List<Package>>(
                        future: packagedetails,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Package>? data = snapshot.data;

                            return SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4.4 / 5,
                              child: ListView.builder(
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    var currentdata = data[index];
                                    var purchasedate =
                                        currentdata.purchaseDate.toString();

                                    var parts = purchasedate.split(' ');
                                    var prchDate = parts[0].trim();
                                    var expirydate =
                                        currentdata.endDate.toString();
                                    var eparts = expirydate.split(' ');
                                    var expDate = eparts[0].trim();

                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "message_available".tr(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${currentdata.postAvailable} ${"advertisement".tr()}",
                                            style: TextStyle(
                                                color: greenColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "action".tr(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                prchDate,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "expaired".tr(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                expDate,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: greenColor,
                              ),
                            );
                          }
                        })
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "boosts".tr(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    FutureBuilder<List<Package>>(
                        future: null,
                        builder: (context, snapshot) {
                          return SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 4.4 / 5,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "post_id".tr(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "2389230923238772",
                                          style: TextStyle(
                                              color: greenColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "action".tr(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            const Text(
                                              "2-12-2022",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "expaired".tr(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            const Text(
                                              "1-1-2023",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        })
                  ],
                ),
        ),
      )),
    );
  }
}
