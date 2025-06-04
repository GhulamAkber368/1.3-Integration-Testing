// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:integration_testing/model/post.dart';
import 'package:integration_testing/respository/post_firebase_repository.dart';

class GetPostFView extends StatefulWidget {
  final PostFirebaseRepository postFirebaseRepository;
  const GetPostFView({super.key, required this.postFirebaseRepository});

  @override
  _GetPostFViewState createState() => _GetPostFViewState();
}

class _GetPostFViewState extends State<GetPostFView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  String message = '';

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Post from Firestore')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FutureBuilder(
                  future: widget.postFirebaseRepository.getPost("2"),
                  builder: (cxt, sp) {
                    if (sp.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (sp.hasError) {
                      return const Text("Something went Wrong");
                    } else {
                      Post post = sp.data!;

                      return Column(
                        children: [
                          const Text("Title:"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${post.title}"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Body:"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("${post.body}"),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
