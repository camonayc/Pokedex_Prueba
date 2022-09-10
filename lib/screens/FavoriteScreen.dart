import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  // final List<int> id;
  final List<String> name;
  final List<String> image;
  // final SharedPreferences datos;

  const FavoriteScreen({
    Key? key,
    // required this.id,
    required this.name,
    required this.image,
    // required this.datos,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.image.isEmpty || widget.name.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.blue[300],
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            backgroundColor: Colors.red,
            title: const Center(
              child: Text(
                'Favorite Pokemons',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ));
    }
    List<String> name2 = widget.name.toSet().toList();
    List<String> image2 = widget.image.toSet().toList();
    return Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          backgroundColor: Colors.red,
          title: const Center(
            child: Text(
              'Favorite Pokemons',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: name2.length,
            itemBuilder: ((context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                shadowColor: Colors.red,
                elevation: 10,
                child: Column(children: [
                  Column(
                    children: [
                      FadeInImage(
                        image: NetworkImage(image2[index]),
                        placeholder: const AssetImage('assets/jar-loading.gif'),
                        fadeInDuration: const Duration(milliseconds: 200),
                        fit: BoxFit.cover,
                        // width: double.infinity,
                      ),
                      const Divider(
                          color: Colors.black, height: 10, thickness: 2),
                      ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          horizontalTitleGap: 10,
                          title: Center(
                              child: Text(name2[index],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                  )))),
                    ],
                  )
                ]),
              );
            })));
  }
}
