// To parse this JSON data, do
//
//     final pokemonsResponses = pokemonsResponsesFromMap(jsonString);

import 'dart:convert';

import 'package:pokedex/models/models.dart';


class PokemonsResponses {
    PokemonsResponses({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Pokemons> results;

    factory PokemonsResponses.fromJson(String str) => PokemonsResponses.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory PokemonsResponses.fromMap(Map<String, dynamic> json) => PokemonsResponses(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Pokemons>.from(json["results"].map((x) => Pokemons.fromMap(x))),
    );

}


