import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_detail_screen.dart';
import 'blog_search.dart';
import 'blogs_provider.dart';
import 'models.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blogsData = Provider.of<BlogsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Blog Explorer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () async {
              final selectedBlog = await showSearch<Blog>(
                context: context,
                delegate: BlogSearch(blogs: blogsData.blogs),
              );
              if (selectedBlog != null) {
                // Handle navigation or other actions when a blog is selected from search
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => BlogDetailScreen(blogId: selectedBlog.id),
                ));
              }
            },
          ),
        ],),
      backgroundColor: Colors.black12,
      body: FutureBuilder(
        future: blogsData.fetchBlogs(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            print(snapshot.error);
            return Center(child: Text('An error occurred!$snapshot.error'));
          } else {
            return ListView.builder(
              itemCount: blogsData.blogs.length,
              itemBuilder: (ctx, index) => Card(
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(blogId: blogsData.blogs[index].id),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: double.infinity,  // to stretch across the screen width
                        child: Image.network(blogsData.blogs[index].imageUrl, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        blogsData.blogs[index].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          blogsData.blogs[index].isFavorite ? Icons.star : Icons.star_border,
                          color: blogsData.blogs[index].isFavorite ? Colors.yellow : null,
                        ),
                        onPressed: () {
                          Provider.of<BlogsProvider>(context, listen: false)
                              .toggleFavorite(blogsData.blogs[index].id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
        },
      ),
    );
  }
}
