import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Adoption_Application {
  Adoption_Application({
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
