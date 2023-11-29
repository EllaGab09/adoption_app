import 'package:uuid/uuid.dart';

/// Represents an application for adoption.
class Application {
  final String id;
  final String animalName;
  final String userName;
  final String message;

  Application(
      {required this.animalName, required this.userName, required this.message})
      : id = const Uuid().v4();
}
