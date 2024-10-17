import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart'; // Ensure this path is correct
import 'post_tile.dart'; // Optional: Custom widget to display each post

class PostGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the post provider to access the posts
    final postProvider = Provider.of<PostProvider>(context);

    // Get the filtered or unfiltered list of posts
    final posts = postProvider.posts;

    // Check if there are posts available
    if (posts.isEmpty) {
      return Center(
        child: Text(
          'No posts found!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    // Display the posts in a vertical list (one after the other)
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: posts.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0), // Space between posts
        child: PostTile(post: posts[i]), // Use PostTile for each post
      ),
    );
  }
}
