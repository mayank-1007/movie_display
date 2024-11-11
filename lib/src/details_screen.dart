import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  const DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['name'] ?? 'Movie Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Movie Image
            Image.network(
              movie['image']?['original'] ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/fallback_image.png', // Local fallback image
                  fit: BoxFit.cover,
                );
              },
            ),
            const SizedBox(height: 16),
            // Movie Title
            Text(
              movie['name'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Movie Summary
            Text(
              movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? 'No Summary',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
