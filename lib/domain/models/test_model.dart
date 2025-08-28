// ignore_for_file: constant_identifier_names

import 'dart:convert';

TestModel testModelFromJson(String str) =>
    TestModel.fromJson(json.decode(str));

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  final Info info;
  final List<Result> results;

  TestModel({
    required this.info,
    required this.results,
  });

  factory TestModel.empty() => TestModel(
        info: Info.empty(),
        results: [],
      );

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        info: json["info"] != null ? Info.fromJson(json["info"])  : Info.empty(),
        results: json["results"] != null  ? List<Result>.from(json["results"].map((x) => Result.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  final String count;
  final String pages;
  final String next;
  final String prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.empty() => Info(
        count: "",
        pages: "",
        next: "",
        prev: "",
      );

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: (json["count"] ?? "").toString(),
        pages: (json["pages"] ?? "").toString(),
        next: (json["next"] ?? "").toString(),
        prev: (json["prev"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Result {
  final String id;
  final String name;
  final Status status;
  final String species;
  final String type;
  final Gender gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Result({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Result.empty() => Result(
        id: "",
        name: "",
        status: Status.UNKNOWN,
        species: "",
        type: "",
        gender: Gender.UNKNOWN,
        origin: Location.empty(),
        location: Location.empty(),
        image: "",
        episode: [],
        url: "",
        created: DateTime.now(),
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        status: statusValues.map[json["status"] ?? "unknown"] ?? Status.UNKNOWN,
        species: (json["species"] ?? "").toString(),
        type: (json["type"] ?? "").toString(),
        gender: genderValues.map[json["gender"] ?? "unknown"] ?? Gender.UNKNOWN,
        origin: json["origin"] != null
            ? Location.fromJson(json["origin"])
            : Location.empty(),
        location: json["location"] != null
            ? Location.fromJson(json["location"])
            : Location.empty(),
        image: (json["image"] ?? "").toString(),
        episode: json["episode"] != null
            ? List<String>.from(json["episode"].map((x) => (x ?? "").toString()))
            : [],
        url: (json["url"] ?? "").toString(),
        created: json["created"] != null
            ? DateTime.tryParse(json["created"].toString()) ?? DateTime.now()
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": species,
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "unknown": Gender.UNKNOWN
});

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.empty() => Location(name: "", url: "");

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: (json["name"] ?? "").toString(),
        url: (json["url"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues({
  "Alive": Status.ALIVE,
  "Dead": Status.DEAD,
  "unknown": Status.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
