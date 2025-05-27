import 'dart:convert';

LineModel lineModelFromJson(String str) => LineModel.fromJson(json.decode(str));

String lineModelToJson(LineModel data) => json.encode(data.toJson());

class LineModel {
    String? id;
    String? name;
    String? details;
    String? mfin;
    String? scode;
    String? area;
    String? baddebt;

    LineModel({
        this.id,
        this.name,
        this.details,
        this.mfin,
        this.scode,
        this.area,
        this.baddebt,
    });

    factory LineModel.fromJson(Map<String, dynamic> json) => LineModel(
        id: json["id"],
        name: json["name"],
        details: json["details"],
        mfin: json["mfin"],
        scode: json["scode"],
        area: json["area"],
        baddebt: json["baddebt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
        "mfin": mfin,
        "scode": scode,
        "area": area,
        "baddebt": baddebt,
    };
}