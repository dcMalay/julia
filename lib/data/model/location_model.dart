class Location {
  Location({
    required this.id,
    required this.locationName,
    required this.v,
  });

  String id;
  String locationName;
  int v;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        locationName: json["location_name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location_name": locationName,
        "__v": v,
      };
}
