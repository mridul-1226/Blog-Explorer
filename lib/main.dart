import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_list_screen.dart';
import 'blogs_provider.dart';

void main() => runApp(const BlogExplorerApp());

class BlogExplorerApp extends StatelessWidget {
  const BlogExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BlogsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog Explorer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const BlogListScreen(),
      ),
    );
  }
}
