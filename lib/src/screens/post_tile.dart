import 'package:flutter/material.dart';
import 'post_model.dart'; // Import your model file

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    // Calculate time since post
    final timeAgo = DateTime.now().difference(post.timestamp).inHours;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with poster image and name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage(post.posterImage), // Profile image
                  radius: 20,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    post.posterName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${timeAgo}h ago', // Time since post
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Post image
          Image.asset(
            post.imageUrl,
            fit: BoxFit.cover,
          ),
          // Description and hashtags
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.description,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Wrap(
                  spacing: 4.0,
                  children: post.hashtags
                      .map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: Colors.blue[100],
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
