import 'package:flutter/material.dart';
import 'package:adoption_app/models/animal.dart';

class AnimalItem extends StatelessWidget {
  const AnimalItem({super.key, required this.animal});

  final Animal animal;
  // final void Function(Animal animal) onSelectAnimal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Image.network(
              animal.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black45,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(children: [
                  Text(
                    animal.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
