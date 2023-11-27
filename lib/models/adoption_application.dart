import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Adoption_Application {
  Adoption_Application({
    required this.userId,
  }) : applicationId = uuid.v4();

  final String applicationId;
  final String userId;
}
