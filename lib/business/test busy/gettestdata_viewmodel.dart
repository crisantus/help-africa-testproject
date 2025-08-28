import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_africa_test/core/constant/constants.dart';
import 'package:help_africa_test/data/repository_impl/repository/test_repo_impl.dart';
import 'package:help_africa_test/domain/models/test_model.dart';

/// StateNotifier that manages fetching and storing paginated TestModel data
/// Uses Riverpod to expose data and states (loading, error, data)
class GetTestDataViewModel extends StateNotifier<AsyncValue<TestModel>> {
  final TestRepositoryImpl _testRepoImpl; // Repository to fetch data

  int _currentPage = 1; // Tracks current page for pagination
  bool _isFetching = false; // Prevents multiple simultaneous requests
  bool _hasMore = true; // Indicates if more pages are available
  TestModel _cachedData = TestModel.empty(); // Stores all fetched data

  /// Constructor
  /// Starts with loading state and immediately fetches the first page
  GetTestDataViewModel(this._testRepoImpl) : super(const AsyncValue.loading()) {
    fetchNextPage();
  }

  /// Returns whether more pages are available
  bool get hasMore => _hasMore;

  /// Fetch the next page of data and append to existing results
  Future<void> fetchNextPage() async {
    // If already fetching or no more pages, do nothing
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    // Fetch data from repository
    final res = await _testRepoImpl.getTestData(page: _currentPage.toString());

    res.fold(
      // Failure case: set state to error with message
      (failure) {
        state = AsyncValue.error(
          HandleError().handleErrorCodeMessage(failure),
          StackTrace.current,
        );
      },
      // Success case: handle and store the results
      (response) {
        // If server returned no results, we've reached the last page
        if (response.results.isEmpty) {
          _hasMore = false;
          return;
        }

        // Append new results to cached results
        _cachedData = TestModel(
          info: response.info,
          results: [..._cachedData.results, ...response.results],
        );

        // Update state with the combined data
        state = AsyncValue.data(_cachedData);

        // Check if there are more pages using the total pages from API
        final totalPages = int.tryParse(response.info.pages) ?? _currentPage;
        if (_currentPage < totalPages) {
          _currentPage++; // Prepare for next page
        } else {
          _hasMore = false; // No more pages to fetch
        }
      },
    );

    _isFetching = false; // Reset fetching flag
  }

  /// Refresh all data from page 1
  /// Clears cached data and resets pagination
  Future<void> refreshAll() async {
    _currentPage = 1;
    _hasMore = true;
    _cachedData = TestModel.empty();
    state = const AsyncValue.loading(); // Show loading state
    await fetchNextPage(); // Fetch first page
  }
}

/// Riverpod StateNotifierProvider for GetTestDataViewModel
/// Allows UI to watch for changes in the data
final getTestDataProvider = StateNotifierProvider.autoDispose<GetTestDataViewModel, AsyncValue<TestModel>>(
  (ref) {
    final testRepo = ref.read(testRepoProvider); // Get repository
    final notifier = GetTestDataViewModel(testRepo); // Initialize notifier
    ref.keepAlive(); // Keep state alive even with autoDispose
    return notifier;
  },
);
