// To parse this JSON data, do
//
//     final busquedaAvanzada = busquedaAvanzadaFromJson(jsonString);

import 'dart:convert';

BusquedaAvanzada busquedaAvanzadaFromJson(String str) =>
    BusquedaAvanzada.fromJson(json.decode(str));

String busquedaAvanzadaToJson(BusquedaAvanzada data) =>
    json.encode(data.toJson());

class BusquedaAvanzada {
  final Info info;
  final List<Result> results;

  BusquedaAvanzada({
    required this.info,
    required this.results,
  });

  factory BusquedaAvanzada.fromJson(Map<String, dynamic> json) =>
      BusquedaAvanzada(
        info: Info.fromJson(json["info"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  final int count;
  final int pages;
  final String next;
  final dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class Result {
  final int id;
  final String name;
  final Status status;
  final Species species;
  final Type type;
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]]!,
        type: typeValues.map[json["type"]]!,
        gender: genderValues.map[json["gender"]]!,
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": typeValues.reverse[type],
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

enum Gender { MALE }

final genderValues = EnumValues({"Male": Gender.MALE});

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Species { HUMAN }

final speciesValues = EnumValues({"Human": Species.HUMAN});

enum Status { ALIVE }

final statusValues = EnumValues({"Alive": Status.ALIVE});

enum Type { CLONE, EMPTY, SOULLESS_PUPPET }

final typeValues = EnumValues({
  "Clone": Type.CLONE,
  "": Type.EMPTY,
  "Soulless Puppet": Type.SOULLESS_PUPPET
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
