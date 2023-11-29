import 'package:uuid/uuid.dart';

const uuid = Uuid();

/// Represents an adoption application for a pet.
class AdoptionApplication {
  AdoptionApplication({
    required this.userId,
    required this.animalId,
    required this.applicationStatus,
    required this.applicationDate,
    required this.applicationMessage,
  }) : applicationId = uuid.v4();

  final String applicationId;
  final String userId;
  final String animalId;
  final String applicationStatus;
  final String applicationDate; //?
  final String applicationMessage;
}
