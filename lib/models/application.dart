// Model representing an application for adopting an animal
class Application {
  final String id; // Unique identifier for the application
  final String userName; // Name of the user submitting the application
  final String message; // Message included in the application

  // Constructor to initialize the application with required parameters
  Application({
    required this.id,
    required this.userName,
    required this.message,
  });
}
