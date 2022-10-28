



class Myads {
  Myads({
    required this.id,
    required this.postCategory,
    required this.postSubcategory,
    required this.postStatus,
    required this.postUserId,
    required this.postFeatured,
    required this.postLocation,
    required this.postCity,
    required this.fields,
    required this.postTitle,
    required this.postImage,
    required this.postSold,
    required this.postPrice,
    required this.postDescription,
    required this.authName,
    required this.postDate,
    required this.v,
  });

  String id;
  PostCategory postCategory;
  PostSubcategory postSubcategory;
  String postStatus;
  PostUserId postUserId;
  int postFeatured;
  PostLocation postLocation;
  PostCity postCity;
  Fields fields;
  PostTitle postTitle;
  List<PostImage> postImage;
  String postSold;
  int postPrice;
  PostDescription postDescription;
  AuthName authName;
  DateTime postDate;
  int v;

  factory Myads.fromJson(Map<String, dynamic> json) => Myads(
        id: json["_id"],
        postCategory: postCategoryValues.map[json["post_category"]]!,
        postSubcategory: postSubcategoryValues.map[json["post_subcategory"]]!,
        postStatus: json["post_status"],
        postUserId: postUserIdValues.map[json["post_user_id"]]!,
        postFeatured: json["post_featured"],
        postLocation: postLocationValues.map[json["post_location"]]!,
        postCity: postCityValues.map[json["post_city"]]!,
        fields: fieldsValues.map[json["fields"]]!,
        postTitle: postTitleValues.map[json["post_title"]]!,
        postImage: List<PostImage>.from(
            json["post_image"].map((x) => postImageValues.map[x])),
        postSold: json["post_sold"],
        postPrice: json["post_price"],
        postDescription: postDescriptionValues.map[json["post_description"]]!,
        authName: authNameValues.map[json["auth_name"]]!,
        postDate: DateTime.parse(json["post_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_category": postCategoryValues.reverse[postCategory],
        "post_subcategory": postSubcategoryValues.reverse[postSubcategory],
        "post_status": postStatus,
        "post_user_id": postUserIdValues.reverse[postUserId],
        "post_featured": postFeatured,
        "post_location": postLocationValues.reverse[postLocation],
        "post_city": postCityValues.reverse[postCity],
        "fields": fieldsValues.reverse[fields],
        "post_title": postTitleValues.reverse[postTitle],
        "post_image": List<dynamic>.from(
            postImage.map((x) => postImageValues.reverse[x])),
        "post_sold": postSold,
        "post_price": postPrice,
        "post_description": postDescriptionValues.reverse[postDescription],
        "auth_name": authNameValues.reverse[authName],
        "post_date": postDate.toIso8601String(),
        "__v": v,
      };
}

enum AuthName { MALAY, TEST_USER, AUTH_NAME_MALAY }

final authNameValues = EnumValues({
  "Malay ": AuthName.AUTH_NAME_MALAY,
  "malay": AuthName.MALAY,
  "test user": AuthName.TEST_USER
});

enum Fields { EMPTY }

final fieldsValues = EnumValues({"{}": Fields.EMPTY});

enum PostCategory {
  THE_634_CF74_A34_B3_E19013_BAEE0_D,
  THE_634_CF6_A734_B3_E19013_BAEDD3,
  THE_634_CF69_E34_B3_E19013_BAEDD1
}

final postCategoryValues = EnumValues({
  "634cf69e34b3e19013baedd1": PostCategory.THE_634_CF69_E34_B3_E19013_BAEDD1,
  "634cf6a734b3e19013baedd3": PostCategory.THE_634_CF6_A734_B3_E19013_BAEDD3,
  "634cf74a34b3e19013baee0d": PostCategory.THE_634_CF74_A34_B3_E19013_BAEE0_D
});

enum PostCity { KOLKATA, THE_6353_E6_EDE596901482_A5_B296 }

final postCityValues = EnumValues({
  "kolkata": PostCity.KOLKATA,
  "6353e6ede596901482a5b296": PostCity.THE_6353_E6_EDE596901482_A5_B296
});

enum PostDescription {
  DESCRIPTION_NATURAL,
  TEST_DESCRIPTION,
  POST_DESCRIPTION_TEST_DESCRIPTION
}

final postDescriptionValues = EnumValues({
  "description natural ": PostDescription.DESCRIPTION_NATURAL,
  " test description": PostDescription.POST_DESCRIPTION_TEST_DESCRIPTION,
  "test description ": PostDescription.TEST_DESCRIPTION
});

enum PostImage {
  THE_41_B3_C2276_A6459_BF1_A8_D196118_CE91_A57_CA1_A9_E3_JPG,
  THE_9_CC0_FC5_FFDC257503_F61_E3_BFCD538_E74744_BC82_E_JPG,
  THE_6_DB422_F2_F51_A40_D98_B20571397_EB24_EF3_B903938_JPG,
  THE_921_F1520_B248_F05_F250_B6_E0585_F958_FED79_E2_DC9_JPG,
  THE_4_EE86_AF0_F155_A6_BB4_C59_F9_E9_AA0003_AB43868052_JPG,
  THE_86_A4_A518423879_B6396_CDA0_CE3_E06555_B5549435_JPG,
  THE_2_ED461_F75_C0_A126_D77_C4_D5_C4886563799_E6_BDA9_A_JPG,
  THE_30_DE71_C3_BC450_E49_FE206886_F0_F55_E9_E139_C6_A5_F_JPG,
  THE_59_BB8412610_BBAF918_F765_E819_A246_F167_A7_ED18_PNG
}

final postImageValues = EnumValues({
  "2ed461f75c0a126d77c4d5c4886563799e6bda9a.jpg":
      PostImage.THE_2_ED461_F75_C0_A126_D77_C4_D5_C4886563799_E6_BDA9_A_JPG,
  "30de71c3bc450e49fe206886f0f55e9e139c6a5f.jpg":
      PostImage.THE_30_DE71_C3_BC450_E49_FE206886_F0_F55_E9_E139_C6_A5_F_JPG,
  "41b3c2276a6459bf1a8d196118ce91a57ca1a9e3.jpg":
      PostImage.THE_41_B3_C2276_A6459_BF1_A8_D196118_CE91_A57_CA1_A9_E3_JPG,
  "4ee86af0f155a6bb4c59f9e9aa0003ab43868052.jpg":
      PostImage.THE_4_EE86_AF0_F155_A6_BB4_C59_F9_E9_AA0003_AB43868052_JPG,
  "59bb8412610bbaf918f765e819a246f167a7ed18.png":
      PostImage.THE_59_BB8412610_BBAF918_F765_E819_A246_F167_A7_ED18_PNG,
  "6db422f2f51a40d98b20571397eb24ef3b903938.jpg":
      PostImage.THE_6_DB422_F2_F51_A40_D98_B20571397_EB24_EF3_B903938_JPG,
  "86a4a518423879b6396cda0ce3e06555b5549435.jpg":
      PostImage.THE_86_A4_A518423879_B6396_CDA0_CE3_E06555_B5549435_JPG,
  "921f1520b248f05f250b6e0585f958fed79e2dc9.jpg":
      PostImage.THE_921_F1520_B248_F05_F250_B6_E0585_F958_FED79_E2_DC9_JPG,
  "9cc0fc5ffdc257503f61e3bfcd538e74744bc82e.jpg":
      PostImage.THE_9_CC0_FC5_FFDC257503_F61_E3_BFCD538_E74744_BC82_E_JPG
});

enum PostLocation {
  SIPALIWINI,
  NICKERIE,
  PARAMARIBO,
  THE_6353_D8_EDE596901482_A5_B1_E0
}

final postLocationValues = EnumValues({
  "Nickerie": PostLocation.NICKERIE,
  "Paramaribo": PostLocation.PARAMARIBO,
  "Sipaliwini": PostLocation.SIPALIWINI,
  "6353d8ede596901482a5b1e0": PostLocation.THE_6353_D8_EDE596901482_A5_B1_E0
});

enum PostSubcategory {
  THE_634_CFEB534_B3_E19013_BAEFB3,
  THE_634_CF96934_B3_E19013_BAEEBA,
  THE_634_CF8_FC34_B3_E19013_BAEEB6
}

final postSubcategoryValues = EnumValues({
  "634cf8fc34b3e19013baeeb6": PostSubcategory.THE_634_CF8_FC34_B3_E19013_BAEEB6,
  "634cf96934b3e19013baeeba": PostSubcategory.THE_634_CF96934_B3_E19013_BAEEBA,
  "634cfeb534b3e19013baefb3": PostSubcategory.THE_634_CFEB534_B3_E19013_BAEFB3
});

enum PostTitle { NATURE, TEST_TITLE, TITLE, POST_TITLE_TEST_TITLE }

final postTitleValues = EnumValues({
  "Nature ": PostTitle.NATURE,
  "Test title": PostTitle.POST_TITLE_TEST_TITLE,
  "test title ": PostTitle.TEST_TITLE,
  "title": PostTitle.TITLE
});

enum PostUserId { THE_63551_A04_E596901482_A5_C191 }

final postUserIdValues = EnumValues(
    {"63551a04e596901482a5c191": PostUserId.THE_63551_A04_E596901482_A5_C191});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
