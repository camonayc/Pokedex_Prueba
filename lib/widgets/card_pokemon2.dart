import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/models.dart';

class CardPokemon2 extends StatelessWidget {
  final String namePokemon;
  final int id;
  final String image;

  const CardPokemon2({
    super.key,
    required this.namePokemon,
    required this.id,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      shadowColor: Colors.red,
      elevation: 10,
      child: Column(
        children: [
          Column(
            children: [
              FadeInImage(
                image: NetworkImage(image),
                placeholder: const AssetImage('assets/jar-loading.gif'),
                fadeInDuration: const Duration(milliseconds: 200),
                fit: BoxFit.cover,
                // width: double.infinity,
              ),
              const Divider(color: Colors.black, height: 10, thickness: 2),
              ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      '${id + 1}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  horizontalTitleGap: 10,
                  title: Center(
                      child: Text(namePokemon,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                          ))))
            ],
          )
        ],
      ),
    );
  }
}
