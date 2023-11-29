import 'package:uuid/uuid.dart';

class Application {
  final String id;
  final String userName;
  final String message;

  Application({required this.userName, required this.message})
      : id = const Uuid().v4();
}
