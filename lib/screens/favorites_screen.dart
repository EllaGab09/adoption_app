import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/providers/favorites_provider.dart';
import 'package:adoption_app/screens/animal_details_screen.dart';
import 'package:adoption_app/widgets/animal_item.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  void selectAnimal(BuildContext context, Animal animal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnimalDetailScreen(animal: animal),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAnimals = ref.watch(favoritesAnimalProvider);

    return Scaffold(
      appBar: const LogoAppBar(),
      body: favoriteAnimals.isEmpty
          ? const Center(
              child: Text('Nothing is here. Please add your favorite animals'),
            )
          : ListView.builder(
              itemCount: favoriteAnimals.length,
              itemBuilder: (context, index) => AnimalItem(
                  animal: favoriteAnimals[index],
                  onSelectAnimal: (animal) {
                    selectAnimal(context, animal);
                  }),
            ),
    );
  }
}
