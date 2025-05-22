// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:integration_testing/post/APIs/get_posts_view.dart';
import 'package:integration_testing/respository/post_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  PostRepository postRepository = PostRepository(http.Client());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginView(),
      home: PostsView(postRepository: postRepository),
    );
  }
}
