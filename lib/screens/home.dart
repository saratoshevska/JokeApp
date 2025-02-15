import 'package:flutter/material.dart';
import 'package:lab2/services/api.dart';
import 'package:lab2/screens/jokeType.dart';
import 'package:lab2/screens/favorites.dart'; // Import FavoritesPage

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<String> favoriteJokes = []; // List to store favorite jokes

  void toggleFavorite(String joke) {
    setState(() {
      if (favoriteJokes.contains(joke)) {
        favoriteJokes.remove(joke);
      } else {
        favoriteJokes.add(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.mood, size: 30),
            SizedBox(width: 10),
            Text(
              'JokeApp',
              style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
            ),
          ],
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          // Navigate to the Favorites Page
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(favorites: favoriteJokes),
                ),
              );
            },
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/random');
            },
            icon: Icon(Icons.lightbulb, color: Colors.yellowAccent, size: 28),
            label: Text(
              'Joke of the Day',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: apiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.deepOrange));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Oops! Something went wrong.',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JokeTypeScreen(type: jokeTypes[index]),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orangeAccent, Colors.pinkAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.emoji_emotions,
                                color: Colors.yellow, size: 30),
                            SizedBox(width: 16),
                            Text(
                              jokeTypes[index],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                favoriteJokes.contains(jokeTypes[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteJokes.contains(jokeTypes[index])
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () {
                                toggleFavorite(jokeTypes[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No jokes found!',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/random');
        },
        icon: Icon(Icons.lightbulb, color: Colors.white),
        label: Text(
          'Joke of the Day',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
