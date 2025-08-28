import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_africa_test/business/test%20busy/gettestdata_viewmodel.dart';
import 'package:help_africa_test/core/route/app_router.dart';
import 'package:help_africa_test/domain/models/test_model.dart';

/// HomeScreen displays a list of TestModel items with pagination
/// User can tap an item to see details
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController(); // Tracks list scroll

  @override
  void initState() {
    super.initState();

    // Listen to scroll events to automatically fetch the next page
    _scrollController.addListener(() {
      final notifier = ref.read(getTestDataProvider.notifier);

      // If user scrolls near the bottom AND more pages exist, fetch next page
      if (_scrollController.position.pixels >=  _scrollController.position.maxScrollExtent - 100 && notifier.hasMore) {
        notifier.fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose controller when widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state of the provider: loading, error, or data
    final state = ref.watch(getTestDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: state.when(
        // While fetching data, show a loading spinner
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),

        // If an error occurs, show error message and a refresh button
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error.toString()), // Show error text
              IconButton(
                onPressed: () async {
                  // When refresh pressed, reload all data
                  await ref.read(getTestDataProvider.notifier).refreshAll();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
        ),

        // When data is available
        data: (TestModel data) {
          if (data.results.isEmpty) {
            // If API returns empty results
            return const Center(child: Text("No data available"));
          }

          // Display data in a scrollable list with pull-to-refresh
          return RefreshIndicator(
            onRefresh: () async {
              // Pull down to refresh triggers reload from page 1
              await ref.read(getTestDataProvider.notifier).refreshAll();
            },
            child: ListView.separated(
              controller: _scrollController, // Attach scroll controller
              itemCount: data.results.length + 1, // Extra item for bottom loader/message
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (index < data.results.length) {
                  // Regular list item
                  final item = data.results[index];
                  return ListTile(
                    leading: Image.network(item.image, width: 50, height: 50),
                    title: Text(item.name),
                    subtitle: Text(
                      "Status: ${item.status.name}, Gender: ${item.gender.name}",
                    ),
                    onTap: () {
                      // Navigate to detail page when tapped
                      context.router.push(TestDetailRoute(item: item));
                    },
                  );
                } else {
                  // Bottom indicator item
                  final notifier = ref.read(getTestDataProvider.notifier);

                  // If more pages exist, show loading spinner
                  if (notifier.hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.purple),
                      ),
                    );
                  } else {
                    // If no more pages, show "No more data" message
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: Text("No more data")),
                    );
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
