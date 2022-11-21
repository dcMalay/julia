import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/seller_data_model.dart';
import 'package:julia/data/repository/get_seller_data_rating_repo.dart';

class SellerReviewSection extends StatefulWidget {
  const SellerReviewSection(
      {super.key, required this.avgRating, required this.userId});
  final double avgRating;
  final String userId;

  @override
  State<SellerReviewSection> createState() => _SellerReviewSectionState();
}

class _SellerReviewSectionState extends State<SellerReviewSection> {
  late Future<SellerDataModel> sellerData;

  @override
  void initState() {
    sellerData = getSellerdata(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SellerDataModel>(
        future: sellerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      snapshot.data!.data[0].userImage.contains('http')
                          ? 'https://api.minimalavatars.com/avatar/random/png'
                          : 'https://julia.sr/uploads/${snapshot.data!.data[0].userImage}',
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        snapshot.data!.data[0].userName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: yellowColor,
                          ),
                          Text(widget.avgRating.toStringAsFixed(1))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
        });
  }
}
