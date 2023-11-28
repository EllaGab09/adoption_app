import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adoption_app/models/application.dart'; // Import the Application model

final applicationProvider =
    StateNotifierProvider<ApplicationNotifier, List<Application>>((ref) {
  return ApplicationNotifier();
});

class ApplicationNotifier extends StateNotifier<List<Application>> {
  ApplicationNotifier() : super([]);

  void addApplication(Application application) {
    state = [...state, application];
  }

  void removeApplication(Application application) {
    state = state.where((element) => element.id != application.id).toList();
  }
}
