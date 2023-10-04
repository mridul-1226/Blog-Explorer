import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blogs_provider.dart';

class BlogDetailScreen extends StatelessWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    // Fetch the blog using the blogId
    final blog = Provider.of<BlogsProvider>(context, listen: false).findById(blogId);

    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(blog.imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // ... other widgets ...
          ],
        ),
      ),
      floatingActionButton: Consumer<BlogsProvider>(
        builder: (ctx, blogsData, _) => FloatingActionButton(
          onPressed: () {
            blogsData.toggleFavorite(blog.id);
          },
          child: Icon(
            blog.isFavorite ? Icons.star : Icons.star_border,
            color: blog.isFavorite ? Colors.yellow : null,
          ),
        ),
      ),
    );
  }
}
