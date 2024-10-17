import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_provider.dart';
import 'post_grid.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20), // Adjust height for better layout
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search posts by hashtag...',
                prefixIcon: Icon(Icons.search, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              ),
              onChanged: (query) {
                postProvider.searchPosts(query);
              },
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 243, 195, 252),
        child: PostGrid(),
      ),
    );
  }
}
