import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List movies = [];
  TextEditingController searchController = TextEditingController();

  void searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(hintText: 'Search Movies...'),
          onSubmitted: searchMovies,
        ),
      ),
      body: movies.isEmpty
          ? const Center(child: Text('Search for movies'))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index]['show'];
                return ListTile(
                  leading: Image.network(
                    movie['image']?['medium'] ?? 'https://via.placeholder.com/100',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/fallback_image.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  title: Text(movie['name'] ?? 'No Title'),
                  subtitle: Text(movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? 'No Summary'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
