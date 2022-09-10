import 'package:flutter/material.dart';
import 'package:pokedex/models/models.dart';

class SearchPokemonDelegate extends SearchDelegate<Map<String, List<String>>> {
  final List<String> pokemons;
  List<String> _filter = [];
  Map<String, int> idPokemons;
  Map<String, String> imagePokemons;

  // final List<int> idPokemons2;
  final List<String> imagenes;
  // final List<int> id;
  final List<String> name;
  final List<String> image;
  final List<String> nameB = [];
  final List<String> imageB = [];
  final bool state;
  Map<String, List<String>> map = {'name': [], 'image': []};

  String imagenBase =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png';

  SearchPokemonDelegate(
      this.pokemons,
      this.idPokemons,
      this.imagePokemons,
      // this.idPokemons2,
      this.imagenes,
      // this.id,
      this.name,
      this.image,
      this.state);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          splashRadius: 20,
          iconSize: 20,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close)),
      IconButton(
          onPressed: () {
            map = {};
          },
          icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        splashRadius: 20,
        iconSize: 20,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        onPressed: () async {
          close(context, await map);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[300],
        body: ListView.builder(
            itemBuilder: (context, i) => Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  shadowColor: Colors.red,
                  elevation: 10,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          FadeInImage(
                            image: NetworkImage(
                                imagePokemons[_filter[i]] ?? imagenBase),
                            placeholder:
                                const AssetImage('assets/jar-loading.gif'),
                            fadeInDuration: const Duration(milliseconds: 200),
                            fit: BoxFit.cover,
                          ),
                          const Divider(
                              color: Colors.black, height: 10, thickness: 2),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            horizontalTitleGap: 10,
                            title: Center(
                                child: Text(_filter[i],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                    ))),
                            leading: IconButton(
                                onPressed: () {
                                  print('Se añadio a favoritos');
                                  var pokemonDato = PokemonDato(
                                      _filter[i],
                                      idPokemons[_filter[i]] ?? 132,
                                      imagePokemons[_filter[i]] ?? imagenBase);
                                  map['name']!.add(pokemonDato.name);
                                  map['image']!.add(pokemonDato.image);
                                },
                                icon: const Icon(Icons.favorite)),
                            trailing: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
            itemCount: _filter.length));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = pokemons.where((String) {
      return String.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();

    if (state == false) {
      return Scaffold(
          backgroundColor: Colors.blue[300],
          body: ListView.builder(
              itemBuilder: (context, i) => Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    shadowColor: Colors.red,
                    elevation: 10,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            FadeInImage(
                              image: NetworkImage(
                                  imagePokemons[_filter[i]] ?? imagenBase),
                              placeholder:
                                  const AssetImage('assets/jar-loading.gif'),
                              fadeInDuration: const Duration(milliseconds: 200),
                              fit: BoxFit.cover,
                            ),
                            const Divider(
                                color: Colors.black, height: 10, thickness: 2),
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              horizontalTitleGap: 10,
                              title: Center(
                                  child: Text(_filter[i],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                      ))),
                              leading: IconButton(
                                  onPressed: () {
                                    print('Se añadio a favoritos');
                                    var pokemonDato = PokemonDato(
                                        _filter[i],
                                        idPokemons[_filter[i]] ?? 132,
                                        imagePokemons[_filter[i]] ??
                                            imagenBase);
                                    map['name']!.add(pokemonDato.name);
                                    map['image']!.add(pokemonDato.image);
                                  },
                                  icon: const Icon(Icons.favorite)),
                              trailing: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              itemCount: _filter.length));
    }
    return Scaffold(backgroundColor: Colors.black);
  }
}
