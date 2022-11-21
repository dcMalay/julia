import 'package:flutter/material.dart';
import '../../const/const.dart';
import '../../data/model/reting_model.dart';
import '../../data/repository/get_seller_rating_repo.dart';

class AllReviewScreen extends StatefulWidget {
  const AllReviewScreen({super.key, required this.postUserId});
  final String postUserId;
  @override
  State<AllReviewScreen> createState() => _AllReviewScreenState();
}

class _AllReviewScreenState extends State<AllReviewScreen> {
  late Future<List<RatingModel>> sellerRating;
  @override
  void initState() {
    sellerRating = getSellerRatingDetails(widget.postUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Reviews'),
        backgroundColor: greenColor,
      ),
      body: FutureBuilder<List<RatingModel>>(
          future: sellerRating,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RatingModel>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var currentdata = data[index];
                    var strRating = data[index].reviewTime.toString();
                    var partsR = strRating.split(' ');
                    var prefixR = partsR[0].trim();
                    var timeR = prefixR.split('.');
                    var timepreR = timeR[0].trim();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(currentdata.userName!),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '( $timepreR )',
                                style: const TextStyle(fontSize: 8),
                              )
                            ],
                          ),
                          subtitle: Text(currentdata.review!),
                          trailing: SizedBox(
                            height: 60,
                            width: 60,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: yellowColor,
                                ),
                                Text(currentdata.starRating.toString())
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
          }),
    );
  }
}
