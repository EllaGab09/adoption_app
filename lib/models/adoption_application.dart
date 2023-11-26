import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Adoption_Application{
    Adoption_Application({

    }) : applicationId = uuid.v4();

    final String applicationId;
}