import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing/post/APIs/create_post_view.dart';
import 'package:integration_testing/post/APIs/delete_post_view.dart';
import 'package:integration_testing/post/APIs/get_posts_view.dart';
import 'package:integration_testing/respository/post_repository.dart';
import 'package:http/http.dart' as http;

late PostRepository postRepository;
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    postRepository = PostRepository(http.Client());
  });
  group("Post Tests", () {
    testWidgets(
        "Given Post Repository Class when getPosts Func is called then Posts should be display on Screen",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: PostsView(postRepository: postRepository),
      ));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byKey(const Key("ListTile_0")), findsOneWidget);
    });

    testWidgets(
        "Given Post Repository Class when Create Button is Pressed then Title and Body message should be display on Screen",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CreatePostView(postRepository: postRepository),
      ));

      final createPostBtn = find.byType(ElevatedButton).first;

      await tester.tap(createPostBtn);

      await tester.pump();

      expect(find.text('Title is required'), findsOneWidget);
      expect(find.text('Body is required'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key("titleTextFormField")), "Title");
      await tester.enterText(
          find.byKey(const Key("bodyTextFormField")), "Body");

      await tester.tap(createPostBtn);

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text("Post created with ID: 101"), findsOneWidget);
    });

    testWidgets(
        "Given Post Repository Class when Delete Post button press on Delete Post Screen then Post Deleted Successfully msg should be display",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DeletePostView(postRepository: postRepository),
      ));

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text("Post Deleted Successfully"), findsOneWidget);
    });

    testWidgets(
        "given Post Repository Class when getPosts Func called on Post Screen and something went wrong then Something went Wrong msg should display",
        (tester) async {});
  });
}
