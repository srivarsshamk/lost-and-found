import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/screens/post_provider.dart'; // Remove 'lib/' from the path
import 'src/screens/search_page.dart'; // Remove 'lib/' from the path
import 'src/screens/edit_profile_page.dart'; // Import EditProfilePage

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost & Found',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Set 'Feed' as the default selected index

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    if (index == 0) {
      // Handle upload action
      print('Upload selected');
    } else if (index == 1) {
      // Currently on the feed page
      print('Feed selected');
    } else if (index == 2) {
      // Navigate to the profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lost & Found',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'LOST & FOUND',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.upload),
              title: Text('Upload'),
              onTap: () {
                // Handle upload action here
              },
            ),
            ListTile(
              leading: Icon(Icons.feed),
              title: Text('Feed'),
              onTap: () {
                // Handle feed action here
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(), // Placeholder for Upload page
          SearchPage(), // Feed page content
          Container(), // Placeholder for Profile page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // This will highlight the selected icon
        onTap: _onBottomNavTap,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 214, 213, 213),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
