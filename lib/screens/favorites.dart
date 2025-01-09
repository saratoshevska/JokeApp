import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favorites;

  FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          'No favorite jokes yet!',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                favorites[index],
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {

                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
