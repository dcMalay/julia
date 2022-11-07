class City {
  City({
    required this.id,
    required this.cityName,
    required this.parentLocation,
    required this.v,
  });

  String id;
  String cityName;
  String parentLocation;
  int v;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        cityName: json["city_name"],
        parentLocation: json["parent_location"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "city_name": cityName,
        "parent_location": parentLocation,
        "__v": v,
      };
}
