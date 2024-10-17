import 'package:flutter/material.dart';
import 'post_model.dart'; // Import your model file

class PostProvider with ChangeNotifier {
  List<Post> _posts = [
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'Found a healthy salad in the park!',
      hashtags: ['#lostandfound', '#salad', '#healthy'],
      posterName: 'John Doe',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 1)), // 1 hour ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'A refreshing garden salad was left on a bench.',
      hashtags: ['#found', '#salad'],
      posterName: 'Jane Smith',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 3)), // 3 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'I found a delicious salad at the community center.',
      hashtags: ['#found', '#salad', '#community'],
      posterName: 'Alice Johnson',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 2)), // 2 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'Lost a lovely salad at the picnic.',
      hashtags: ['#lost', '#salad', '#picnic'],
      posterName: 'Michael Brown',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 5)), // 5 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'A salad was found near the playground!',
      hashtags: ['#found', '#salad', '#playground'],
      posterName: 'Emily Davis',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 4)), // 4 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'Someone left a salad on my doorstep.',
      hashtags: ['#lostandfound', '#salad', '#doorstep'],
      posterName: 'Chris Wilson',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 6)), // 6 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'Found a gourmet salad in the library.',
      hashtags: ['#found', '#salad', '#library'],
      posterName: 'Jessica Lee',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 7)), // 7 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'A forgotten salad at the bus stop.',
      hashtags: ['#lost', '#salad', '#busstop'],
      posterName: 'David Harris',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 8)), // 8 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'Found a salad during my morning walk.',
      hashtags: ['#found', '#salad', '#morningwalk'],
      posterName: 'Sophia Clark',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 9)), // 9 hours ago
    ),
    Post(
      imageUrl: 'lib/src/assets/images/salad.jpeg',
      description: 'A salad was left at the art gallery.',
      hashtags: ['#lostandfound', '#salad', '#artgallery'],
      posterName: 'Daniel Lewis',
      posterImage:
          'lib/src/assets/images/profile1.png', // Use profile1.png for all posts
      timestamp: DateTime.now().subtract(Duration(hours: 10)), // 10 hours ago
    ),
  ];

  List<Post> _filteredPosts = [];

  List<Post> get posts => _filteredPosts.isEmpty ? _posts : _filteredPosts;

  void searchPosts(String query) {
    if (query.isEmpty) {
      _filteredPosts = [];
    } else {
      _filteredPosts = _posts
          .where((post) =>
              post.hashtags.any((tag) => tag.contains(query.toLowerCase())))
          .toList();
    }
    notifyListeners();
  }
}
