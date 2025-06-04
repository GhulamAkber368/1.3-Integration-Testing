// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:integration_testing/firebase_options.dart';
import 'package:integration_testing/respository/post_firebase_repository.dart';
import 'package:integration_testing/respository/post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:integration_testing/view/post/firestore_crud/create_post_f_view.dart';
import 'package:integration_testing/view/post/firestore_crud/delete_post_f_view.dart';
import 'package:integration_testing/view/post/firestore_crud/get_post_f_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostRepository postRepository = PostRepository(http.Client());

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late final PostFirebaseRepository postFirebaseRepository;

  @override
  void initState() {
    super.initState();
    postFirebaseRepository = PostFirebaseRepository(firebaseFirestore);
  }

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
      // home: PostsView(postRepository: postRepository),
      // home: CreatePostFView(postFirebaseRepository: postFirebaseRepository),
      // home: GetPostFView(postFirebaseRepository: postFirebaseRepository),
      home: DeletePostFView(postFirebaseRepository: postFirebaseRepository),
    );
  }
}
