import 'package:flutter/material.dart';
import 'package:integration_testing/post/APIs/create_post_view.dart';
import 'package:integration_testing/respository/post_repository.dart';

class PostsView extends StatelessWidget {
  final PostRepository postRepository;
  const PostsView({super.key, required this.postRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: postRepository.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text("No Post Added yet");
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (cxt, i) {
                        final post = snapshot.data![i];
                        return ListTile(
                          key: Key("ListTile_$i"),
                          title: Text(post.title!),
                          subtitle: Text(post.body!),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    key: const Key("navigationBtn"),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (cxt) => CreatePostView(
                                postRepository: postRepository))),
                    child: const Text("Create Post")),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          } else {
            return const Center(child: Text('No post found'));
          }
        },
      ),
    );
  }
}
