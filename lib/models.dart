import 'dart:convert';

class Blog {
  final String id;
  final String title;
  final String imageUrl;
  bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'].toString(),
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}

