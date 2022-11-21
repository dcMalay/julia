class RatingModel {
  RatingModel({
    this.id,
    this.postId,
    this.sellerId,
    this.starRating,
    this.review,
    this.userId,
    this.userName,
    this.reviewTime,
  });

  String? id;
  String? postId;
  String? sellerId;
  double? starRating;
  String? review;
  String? userId;
  String? userName;
  DateTime? reviewTime;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["_id"],
        postId: json["post_id"],
        sellerId: json["seller_id"],
        starRating: json["star_rating"].toDouble(),
        review: json["review"],
        userId: json["user_id"],
        userName: json["user_name"],
        reviewTime: DateTime.parse(json["review_time"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_id": postId,
        "seller_id": sellerId,
        "star_rating": starRating,
        "review": review,
        "user_id": userId,
        "user_name": userName,
        "review_time": reviewTime!.toIso8601String(),
      };
}
