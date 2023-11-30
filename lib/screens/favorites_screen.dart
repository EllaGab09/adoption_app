import 'package:adoption_app/models/animal.dart';
import 'package:adoption_app/providers/favorites_provider.dart';
import 'package:adoption_app/screens/animal_details_screen.dart';
import 'package:adoption_app/widgets/animal_item.dart';
import 'package:adoption_app/widgets/logo_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A screen that displays the user's favorite animals.
///
/// This screen is a [ConsumerWidget] that listens to changes in the favorite animals state
/// and updates the UI accordingly. It provides a visual representation of the user's
/// favorite animals and allows them to interact with those animals.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  /// Selects an animal and navigates to the details screen.
  ///
  /// This method is called when an animal is selected from the favorites screen.
  /// It takes the [BuildContext] and the selected [Animal] as parameters.
  /// It navigates to the details screen to display more information about the selected animal.
  void selectAnimal(BuildContext context, Animal animal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnimalDetailScreen(animal: animal),
      ),
    );
  }

  @override

  /// Builds the favorites screen widget.
  ///
  /// This method is responsible for constructing the UI of the favorites screen.
  /// It takes in the [BuildContext] and [WidgetRef] as parameters.
  /// Returns a [Widget] representing the favorites screen.
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAnimals = ref.watch(favoritesAnimalProvider);

    return Scaffold(
      appBar: const LogoAppBar(),
      body: favoriteAnimals.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Here you can add your favorite animals! Please add your favorite animals by tapping the heart icon on animals details screen!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.favorite_border,
                        size: 100, color: Colors.black)
                  ],
                ),
              ),
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
