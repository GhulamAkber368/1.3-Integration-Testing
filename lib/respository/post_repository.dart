import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integration_testing/model/post.dart';
import 'package:integration_testing/utils/app_urls.dart';

class PostRepository {
  final http.Client client;
  PostRepository(this.client);

  Future<List<Post>> getPosts() async {
    final response = await client.get(Uri.parse(AppUrls.getPosts));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Post.fromJson(e)).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something went wrong");
    }
  }
}
