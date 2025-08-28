

import 'package:help_africa_test/domain/models/test_model.dart';

abstract class TestRemoteDataSource {
   Future< TestModel> getTestData({required String page});
}