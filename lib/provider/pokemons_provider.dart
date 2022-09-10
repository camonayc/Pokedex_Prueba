// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/models.dart';

class PokemonsProvider extends ChangeNotifier {
  bool state1 = false;
  // bool state2 = true;

  final String _baseUrl = 'pokeapi.co';
  final String _limit = '100000';
  final String _offset = '0';

  List<Pokemons> onDisplayPokemos = [];

  PokemonsProvider() {
    getPokemons();
  }

  getPokemons() async {
    var url = Uri.https(
        _baseUrl, 'api/v2/pokemon', {'limit': _limit, 'offset': _offset});

    final response = await http.get(url);
    final nowPokemonsResponse = PokemonsResponses.fromJson(response.body);
    if (nowPokemonsResponse.results.isEmpty) {
      print('please wait a moment');
    } else {
      state1 = true;
      onDisplayPokemos = nowPokemonsResponse.results;      // print(height);
    }
    notifyListeners();
  }
}
