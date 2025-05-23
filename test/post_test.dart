import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_testing/model/post.dart';
import 'package:integration_testing/post/APIs/get_posts_view.dart';
import 'package:integration_testing/respository/post_repository.dart';
import 'package:integration_testing/utils/app_urls.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late PostRepository postRepository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    postRepository = PostRepository(mockHttpClient);
  });

  testWidgets(
      "given Post Repository Class when getPosts Func is called and list is empty then No Post Added yet message should be display",
      (tester) async {
    List<Post> postsList = [];
    when(() => mockHttpClient.get(Uri.parse(AppUrls.getPosts)))
        .thenAnswer((ans) async {
      return Response("$postsList", 200);
    });
    await tester.pumpWidget(MaterialApp(
      home: PostsView(postRepository: postRepository),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text("No Post Added yet"), findsOneWidget);
  });

  testWidgets(
      "given Post Repository Class when getPosts Func is called and some error occured then Something went wrong message should be display",
      (tester) async {
    when(() => mockHttpClient.get(Uri.parse(AppUrls.getPosts)))
        .thenAnswer((ans) async {
      return Response("", 500);
    });
    await tester.pumpWidget(MaterialApp(
      home: PostsView(postRepository: postRepository),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text("Something went wrong"), findsOneWidget);
  });
}
