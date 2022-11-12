class Product {
  String? sId;
  String? postCategory;
  String? postSubcategory;
  String? postStatus;
  String? postUserId;
  int? postFeatured;
  String? postLocation;
  String? fields;
  String? postTitle;
  List<String>? postImage;
  String? postSold;
  num? postPrice;
  String? postDescription;
  String? authName;
  String? postDate;
  int? iV;

  Product(
      {required this.sId,
      required this.postCategory,
      required this.postSubcategory,
      required this.postStatus,
      required this.postUserId,
      required this.postFeatured,
      required this.postLocation,
      required this.fields,
      required this.postTitle,
      required this.postImage,
      required this.postSold,
      required this.postPrice,
      required this.postDescription,
      required this.authName,
      required this.postDate,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postCategory = json['post_category'];
    postSubcategory = json['post_subcategory'];
    postStatus = json['post_status'];
    postUserId = json['post_user_id'];
    postFeatured = json['post_featured'];
    postLocation = json['post_location'];
    fields = json['fields'];
    postTitle = json['post_title'];
    postImage = json['post_image'].cast<String>();
    postSold = json['post_sold'];
    postPrice = json['post_price'];
    postDescription = json['post_description'];
    authName = json['auth_name'];
    postDate = json['post_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['post_category'] = postCategory;
    data['post_subcategory'] = postSubcategory;
    data['post_status'] = postStatus;
    data['post_user_id'] = postUserId;
    data['post_featured'] = postFeatured;
    data['post_location'] = postLocation;
    data['fields'] = fields;
    data['post_title'] = postTitle;
    data['post_image'] = postImage;
    data['post_sold'] = postSold;
    data['post_price'] = postPrice;
    data['post_description'] = postDescription;
    data['auth_name'] = authName;
    data['post_date'] = postDate;
    data['__v'] = iV;
    return data;
  }
}
