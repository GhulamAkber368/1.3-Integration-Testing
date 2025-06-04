// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:integration_testing/model/post.dart';
import 'package:integration_testing/respository/post_firebase_repository.dart';

class CreatePostFView extends StatefulWidget {
  final PostFirebaseRepository postFirebaseRepository;
  const CreatePostFView({super.key, required this.postFirebaseRepository});

  @override
  _CreatePostFViewState createState() => _CreatePostFViewState();
}

class _CreatePostFViewState extends State<CreatePostFView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  String message = '';

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post in Firestore')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                key: const Key("titleTextFormField"),
                decoration: const InputDecoration(
                  labelText: 'Post Title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: bodyController,
                key: const Key("bodyTextFormField"),
                decoration: const InputDecoration(labelText: 'Post Body'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Body is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              widget.postFirebaseRepository.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // try {
                          setState(() {
                            widget.postFirebaseRepository.setIsLoading(true);
                          });

                          Post post = Post(
                              userId: 2,
                              id: 2,
                              title: titleController.text.trim(),
                              body: bodyController.text.trim());

                          final resultMsg = await widget.postFirebaseRepository
                              .setPost(post, post.id.toString());

                          setState(() {
                            message = resultMsg;
                            widget.postFirebaseRepository.setIsLoading(false);
                          });
                          // }
                          // catch (e) {
                          //   setState(() {
                          //     message = e is FirebaseException
                          //         ? "Firebase Exception"
                          //         : "Exception: $e";
                          //   });
                          // }
                          // finally {
                          //   setState(() {
                          //     widget.postFirebaseRepository.setIsLoading(false);
                          //   });
                          // }
                        }
                      },
                      child: const Text('Create Post'),
                    ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
