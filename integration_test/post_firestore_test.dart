import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing/respository/post_firebase_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseRepository extends Mock implements PostFirebaseRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseRepository mockFirebaseRepository;
  late PostFirebaseRepository postFirebaseRepository;
  late FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  setUp(() {
    postFirebaseRepository = PostFirebaseRepository(firebaseFirestore);
    mockFirebaseRepository = MockFirebaseRepository();
  });

  testWidgets(
      "given Post Firebase Repository Clas when Create Post Button press on Create Post View then Post Create msg should be display",
      (tester) async {});
}
