import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:help_africa_test/domain/models/test_model.dart';

@RoutePage()
class TestDetailPage extends StatelessWidget {
  final Result item; // Pass the clicked item

  const TestDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(item.image, width: 150, height: 150),
              ),
              const SizedBox(height: 16),
              Text(
                "Name: ${item.name}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Status: ${item.status.name}"),
              Text("Species: ${item.species}"),
              Text("Gender: ${item.gender.name}"),
              Text("Type: ${item.type.isEmpty ? 'N/A' : item.type}"),
              const SizedBox(height: 8),
              Text("Origin: ${item.origin.name}"),
              Text("Location: ${item.location.name}"),
              const SizedBox(height: 8),
              Text("Episodes: ${item.episode.join(', ')}"),
              const SizedBox(height: 8),
              Text("Created: ${item.created.toLocal()}"),
            ],
          ),
        ),
      ),
    );
  }
}
