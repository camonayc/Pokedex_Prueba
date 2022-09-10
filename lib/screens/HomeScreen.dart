import 'package:flutter/material.dart';
import 'package:pokedex/models/models.dart';
import 'package:pokedex/provider/provider.dart';
import 'package:pokedex/screens/screens.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  bool? estado;
  // List<String>? pokemons;
  // List<String>? imagePokemons;
  HomeScreen({
    Key? key,
    this.estado,
    // this.pokemons,
    // this.imagePokemons
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pokemons = [];

  List<int> idPokemons = [];

  List<String> imagenes = [];

  Map<String, int> pokeId = {};

  Map<String, String> pokeImage = {};

  List<int> id = [];

  List<String> name = [];

  List<String> image = [];

  List<String> saveName = [];

  List<String> saveImage = [];

  List<String> pokemonSave = [];

  List<String> imageSave = [];

  Map<String, List<String>>? result = {};

  mostrarDatos() async {
    SharedPreferences prefers = await SharedPreferences.getInstance();

    pokemonSave = await prefers.getStringList('name')!.toSet().toList();
    imageSave = await prefers.getStringList('image')!.toSet().toList();
  }

  borrarDatos() async {
    SharedPreferences prefers = await SharedPreferences.getInstance();

    await prefers.remove('name');
    await prefers.remove('image');
  }

  @override
  void initState() {
    super.initState();
    mostrarDatos();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonsProvider = Provider.of<PokemonsProvider>(context);

    if (pokemonsProvider.state1 == false) {
      return const Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < pokemonsProvider.onDisplayPokemos.length; i++) {
      pokemons.add(pokemonsProvider.onDisplayPokemos[i].name);
    }
    for (var i = 0; i < pokemonsProvider.onDisplayPokemos.length; i++) {
      idPokemons.add(i);
    }
    for (var i = 0; i < pokemons.length - 256; i++) {
      imagenes.add(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${i + 1}.png');
    }
    for (var i = pokemons.length - 256; i < pokemons.length; i++) {
      imagenes.add(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png');
    }
    for (var i = 0; i < pokemons.length; i++) {
      pokeId.addAll({pokemons[i]: idPokemons[i]});
    }
    for (var i = 0; i < pokemons.length; i++) {
      pokeImage.addAll({pokemons[i]: imagenes[i]});
    }

    guardarDatos(List<String> name, List<String> image) async {
      SharedPreferences prefers = await SharedPreferences.getInstance();

      await prefers.setStringList('name', name);
      await prefers.setStringList('image', image);
      // print('Se agrego el Pokemon: $name de la lista de favoritos');
      return prefers;
    }

    bool state = false;

    return Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          actions: [
            IconButton(
                splashRadius: 20,
                iconSize: 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                onPressed: () {
                  if (pokemonSave != []) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FavoriteScreen(
                        // id: id,
                        image: imageSave + saveImage,
                        name: pokemonSave + saveName,
                        // datos: datos,
                      );
                    }));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FavoriteScreen(
                        // id: id,
                        image: saveImage,
                        name: saveName,
                        // datos: datos,
                      );
                    }));
                  }
                },
                icon: const Icon(Icons.favorite)),
            IconButton(
                splashRadius: 20,
                iconSize: 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                onPressed: () async {
                  result = (await showSearch(
                      context: context,
                      delegate: SearchPokemonDelegate(
                          pokemons,
                          pokeId,
                          pokeImage,
                          // idPokemons,
                          imagenes,
                          // id,
                          name,
                          image,
                          state)));

                  if (result!.isEmpty) {
                    guardarDatos([], []);
                    guardarDatos([], []).then((value) {
                      saveName = value.getStringList('name')!;
                      saveImage = value.getStringList('image')!;
                      pokemonSave = value.getStringList('name')!;
                      imageSave = value.getStringList('image')!;

                      print(value.getStringList('name'));
                    });
                  } else {
                    print('no vacio');
                    if (result!['name']!.isNotEmpty) {
                      await guardarDatos(result!['name']!.toSet().toList(),
                          result!['image']!.toSet().toList());
                      await guardarDatos(result!['name']!.toSet().toList(),
                              result!['image']!.toSet().toList())
                          .then((value) {
                        saveName =
                            value.getStringList('name')!.toSet().toList();
                        saveImage =
                            value.getStringList('image')!.toSet().toList();
                      });
                    }
                  }
                },
                icon: const Icon(
                  Icons.search,
                )),
          ],
          backgroundColor: Colors.red,
          title: const Text(
            'POKEDEX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
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
                            image: NetworkImage(imagenes[i]),
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
                                  child: Text(pokemons[i],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.italic,
                                      ))),
                              leading: IconButton(
                                  onPressed: () async {
                                    if (pokemonSave != []) {
                                      var pokemonDato = PokemonDato(pokemons[i],
                                          idPokemons[i], imagenes[i]);
                                      name = pokemonSave;
                                      image = imageSave;
                                      id.add(pokemonDato.id);
                                      name.add(pokemonDato.name);
                                      image.add(pokemonDato.image);
                                      await guardarDatos(name.toSet().toList(),
                                          image.toSet().toList());
                                      await guardarDatos(name.toSet().toList(),
                                              image.toSet().toList())
                                          .then((value) {
                                        saveName = value
                                            .getStringList('name')!
                                            .toSet()
                                            .toList();
                                        saveImage = value
                                            .getStringList('image')!
                                            .toSet()
                                            .toList();
                                      });
                                      print(
                                          'Se agrego el Pokemon: ${name.toSet().toList()} de la lista de favoritos');
                                    } else {
                                      var pokemonDato = PokemonDato(pokemons[i],
                                          idPokemons[i], imagenes[i]);
                                      id.add(pokemonDato.id);
                                      name.add(pokemonDato.name);
                                      image.add(pokemonDato.image);
                                      await guardarDatos(name.toSet().toList(),
                                          image.toSet().toList());
                                      await guardarDatos(name.toSet().toList(),
                                              image.toSet().toList())
                                          .then((value) {
                                        saveName = value
                                            .getStringList('name')!
                                            .toSet()
                                            .toList();
                                        saveImage = value
                                            .getStringList('image')!
                                            .toSet()
                                            .toList();
                                      });
                                      print(
                                          'Se agrego el Pokemon: ${name.toSet().toList()} de la lista de favoritos');
                                    } // print('Se añadio a favoritos');
                                  },
                                  icon: const Icon(Icons.favorite)),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var pokemonDato = PokemonDato(pokemons[i],
                                        idPokemons[i], imagenes[i]);
                                    name = pokemonSave;
                                    image = imageSave;
                                    id.remove(pokemonDato.id);
                                    name.remove(pokemonDato.name);
                                    image.remove(pokemonDato.image);
                                    await guardarDatos(name.toSet().toList(),
                                        image.toSet().toList());
                                    await guardarDatos(name.toSet().toList(),
                                            image.toSet().toList())
                                        .then((value) {
                                      saveName = value
                                          .getStringList('name')!
                                          .toSet()
                                          .toList();
                                      saveImage = value
                                          .getStringList('image')!
                                          .toSet()
                                          .toList();
                                    });
                                    print(
                                        'Se borro el pokemon: ${pokemonDato.name}');
                                  },
                                  icon: const Icon(Icons.close))),
                        ],
                      )
                    ],
                  ),
                ),
            itemCount: pokemonsProvider.onDisplayPokemos.length));
  }
}
