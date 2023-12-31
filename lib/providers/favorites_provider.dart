import 'package:adoption_app/models/animal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesAnimalsProvider extends StateNotifier<List<Animal>> {
  FavoritesAnimalsProvider() : super([]);

  bool toggleFavoriteAnimal(Animal animal) {
    final animalIsFavorite = state.contains(animal);
    if (animalIsFavorite) {
      state = state.where((element) => element.name != animal.name).toList();
      return false;
    } else {
      state = [...state, animal];
      return true;
    }
  }
}

final favoritesAnimalProvider =
    StateNotifierProvider<FavoritesAnimalsProvider, List<Animal>>(
  (ref) => FavoritesAnimalsProvider(),
);
