// To parse this JSON data, do
//
//     final dynamicForm = dynamicFormFromJson(jsonString);

import 'dart:convert';

List<DynamicForm> dynamicFormFromJson(String str) => List<DynamicForm>.from(
    json.decode(str).map((x) => DynamicForm.fromJson(x)));

String dynamicFormToJson(List<DynamicForm> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DynamicForm {
  DynamicForm({
    required this.id,
    required this.subcategoryId,
    required this.schema,
    required this.v,
  });

  String id;
  String subcategoryId;
  Schema schema;
  int v;

  factory DynamicForm.fromJson(Map<String, dynamic> json) => DynamicForm(
        id: json["_id"],
        subcategoryId: json["subcategory_id"],
        schema: Schema.fromJson(json["schema"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory_id": subcategoryId,
        "schema": schema.toJson(),
        "__v": v,
      };
}

class Schema {
  Schema({
    required this.subcat,
    required this.field,
    required this.fieldtype,
    required this.fielddata,
  });

  String subcat;
  String field;
  String fieldtype;
  String fielddata;

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        subcat: json["subcat"],
        field: json["field"],
        fieldtype: json["fieldtype"],
        fielddata: json["fielddata"],
      );

  Map<String, dynamic> toJson() => {
        "subcat": subcat,
        "field": field,
        "fieldtype": fieldtype,
        "fielddata": fielddata,
      };
}
