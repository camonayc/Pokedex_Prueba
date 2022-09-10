import 'dart:convert';

class Pokemons {
    Pokemons({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory Pokemons.fromJson(String str) => Pokemons.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory Pokemons.fromMap(Map<String, dynamic> json) => Pokemons(
        name: json["name"],
        url: json["url"],
    );
}