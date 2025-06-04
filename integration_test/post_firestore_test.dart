import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing/firebase_options.dart';
import 'package:integration_testing/model/post.dart';
import 'package:integration_testing/respository/post_firebase_repository.dart';
import 'package:integration_testing/view/post/firestore_crud/create_post_f_view.dart';
import 'package:integration_testing/view/post/firestore_crud/delete_post_f_view.dart';
import 'package:integration_testing/view/post/firestore_crud/get_post_f_view.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseRepository extends Mock implements PostFirebaseRepository {}

class FakePost extends Fake implements Post {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseRepository mockFirebaseRepository;
  late PostFirebaseRepository postFirebaseRepository;
  late FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  setUpAll(() {
    registerFallbackValue(FakePost());
  });

  setUp(() {
    postFirebaseRepository = PostFirebaseRepository(firebaseFirestore);
    mockFirebaseRepository = MockFirebaseRepository();
  });

  // group("Post Firebase Set Tests", () {
  //   testWidgets(
  //       "given Post Firebase Repository Clas when Create Post Button press on Create Post View then Post Create msg should be display",
  //       (tester) async {
  //     await tester.pumpWidget(MaterialApp(
  //       home: CreatePostFView(postFirebaseRepository: postFirebaseRepository),
  //     ));

  //     final titleTextField = find.byKey(const Key("titleTextFormField"));
  //     final bodyTextFormField = find.byKey(const Key("bodyTextFormField"));

  //     final createPostBtn = find.byType(ElevatedButton);

  //     await tester.tap(createPostBtn);

  //     await tester.pump();

  //     expect(find.text("Title is required"), findsOneWidget);
  //     expect(find.text("Body is required"), findsOneWidget);

  //     await tester.enterText(titleTextField, "Title");
  //     await tester.enterText(bodyTextFormField, "Body");

  //     await tester.tap(createPostBtn);

  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);

  //     await tester.pumpAndSettle();

  //     expect(find.text("Post Created"), findsOneWidget);
  //   });

  //   testWidgets(
  //       "given Post Firebase Repository Clas when Create Post Button press on Create Post View and there is a firebase exception then firebase exception msg should be display",
  //       (tester) async {
  //     bool isLoadingTest = false;
  //     when(() => mockFirebaseRepository.isLoading)
  //         .thenAnswer((ans) => isLoadingTest);

  //     when(() => mockFirebaseRepository.setPost(any(), any()))
  //         .thenAnswer((ans) async {
  //       isLoadingTest = true;
  //       await Future.delayed(const Duration(seconds: 1));
  //       isLoadingTest = false;
  //       return "Firebase Exception";
  //       // Real Exceptions are thown in Unit Tests.
  //       // Integration Testing don’t force error scenarios by making Firebase throw exceptions.
  //       // Instead, they test happy paths means return String messages instead of Firebase Exception.
  //       // If you throw Firebase Exception here, set Method will throw Firebase Exception directly, on Firebase Exception part will not be executed.
  //       // You can throw Firebase Exception here but you have to handle exception on UI side check commented code of on Press on CreatePostFView
  //       // throw FirebaseException(
  //       //   plugin: "firestore",
  //       //   message: "Firebase Exception",
  //       // );
  //     });

  //     await tester.pumpWidget(MaterialApp(
  //       home: CreatePostFView(postFirebaseRepository: mockFirebaseRepository),
  //     ));

  //     final titleTextField = find.byKey(const Key("titleTextFormField"));
  //     final bodyTextFormField = find.byKey(const Key("bodyTextFormField"));

  //     final createPostBtn = find.byType(ElevatedButton);

  //     await tester.enterText(titleTextField, "Title");
  //     await tester.enterText(bodyTextFormField, "Body");

  //     await tester.tap(createPostBtn);

  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);

  //     await tester.pumpAndSettle();

  //     expect(find.text("Firebase Exception"), findsOneWidget);
  //   });
  // });

  group("Get Post Tests", () {
    // testWidgets(
    //     "Give Post Respository class when Get Post Func called then Post should display",
    //     (tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: GetPostFView(postFirebaseRepository: postFirebaseRepository),
    //   ));

    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //   await tester.pumpAndSettle();

    //   expect(find.text("Title:"), findsOneWidget);
    //   expect(find.text("Body:"), findsOneWidget);
    // });

    // testWidgets(
    //     "Give Post Respository class when Get Post Func called and Something went Wrong then Something went Wrong message should be display",
    //     (tester) async {
    //   bool isLoadingTest = false;
    //   when(() => mockFirebaseRepository.isLoading)
    //       .thenAnswer((ans) => isLoadingTest);

    //   when(() => mockFirebaseRepository.getPost(any())).thenAnswer((ans) async {
    //     isLoadingTest = true;
    //     Future.delayed(const Duration(seconds: 1));
    //     isLoadingTest = false;
    //     throw FirebaseException(plugin: "firestore");
    //   });
    //   await tester.pumpWidget(MaterialApp(
    //     home: GetPostFView(postFirebaseRepository: mockFirebaseRepository),
    //   ));

    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //   await tester.pumpAndSettle();

    //   expect(find.text("Something went Wrong"), findsOneWidget);
    // });
  });

  testWidgets(
      "given Post Firebase Respository when Delete Post button pressed and Post is Deleted then Post Deleted msg should display.",
      (tester) async {
    bool isLoadingTest = false;
    when(() => mockFirebaseRepository.isLoading)
        .thenAnswer((ans) => isLoadingTest);

    when(() => mockFirebaseRepository.deletePost(any()))
        .thenAnswer((ans) async {
      isLoadingTest = true;
      await Future.delayed(const Duration(seconds: 1));
      isLoadingTest = false;
      return "Post Deleted";
    });

    await tester.pumpWidget(MaterialApp(
      home: DeletePostFView(postFirebaseRepository: mockFirebaseRepository),
    ));

    final deletePostBtn = find.byType(ElevatedButton);

    await tester.tap(deletePostBtn);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text("Post Deleted"), findsOneWidget);
  });
}
