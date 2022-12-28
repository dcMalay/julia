class Geolocation {
  Geolocation({
    this.placeId,
    this.licence,
    this.poweredBy,
    this.osmType,
    this.osmId,
    this.boundingbox,
    this.lat,
    this.lon,
    this.displayName,
    this.geolocationClass,
    this.type,
    this.importance,
  });

  int? placeId;
  String? licence;
  PoweredBy? poweredBy;
  OsmType? osmType;
  int? osmId;
  List<String>? boundingbox;
  String? lat;
  String? lon;
  String? displayName;
  String? geolocationClass;
  String? type;
  double? importance;

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        placeId: json["place_id"],
        licence: json["licence"],
        poweredBy: poweredByValues.map[json["powered_by"]],
        osmType: osmTypeValues.map[json["osm_type"]],
        osmId: json["osm_id"],
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        geolocationClass: json["class"],
        type: json["type"],
        importance: json["importance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "powered_by": poweredByValues.reverse[poweredBy],
        "osm_type": osmTypeValues.reverse[osmType],
        "osm_id": osmId,
        "boundingbox": List<dynamic>.from(boundingbox!.map((x) => x)),
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "class": geolocationClass,
        "type": type,
        "importance": importance,
      };
}

enum OsmType { RELATION, WAY, NODE }

final osmTypeValues = EnumValues(
    {"node": OsmType.NODE, "relation": OsmType.RELATION, "way": OsmType.WAY});

enum PoweredBy { MAP_MAKER_HTTPS_MAPS_CO }

final poweredByValues = EnumValues(
    {"Map Maker: https://maps.co": PoweredBy.MAP_MAKER_HTTPS_MAPS_CO});

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
