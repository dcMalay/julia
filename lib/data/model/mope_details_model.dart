



class Mopedetails {
  Mopedetails({
    required this.data,
    required this.total,
    required this.nop,
  });

  Data data;
  int total;
  int nop;

  factory Mopedetails.fromJson(Map<String, dynamic> json) => Mopedetails(
        data: Data.fromJson(json["data"]),
        total: json["total"],
        nop: json["nop"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "total": total,
        "nop": nop,
      };
}

class Data {
  Data({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
