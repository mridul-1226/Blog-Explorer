import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class BlogsProvider with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get blogs => [..._blogs];

  bool _isLoaded = false;

  Future<void> fetchBlogs() async {
    if (_isLoaded) return;
    final url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final headers = {
      'x-hasura-admin-secret': '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<
          dynamic> blogData = responseData['blogs']; // Extract 'blogs' key

      _blogs = blogData.map((e) => Blog.fromJson(e)).toList();
      notifyListeners();
      _isLoaded = true;
    } catch (error) {
      throw (error);
    }
  }



  void toggleFavorite(String id) {
    final index = _blogs.indexWhere((blog) => blog.id == id);
    _blogs[index].isFavorite = !_blogs[index].isFavorite;
    notifyListeners();
  }

  Blog findById(String id) {
    return _blogs.firstWhere((blog) => blog.id == id);
  }
}

