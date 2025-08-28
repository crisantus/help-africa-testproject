
import 'package:help_africa_test/core/network/services_instance.dart';
import 'package:help_africa_test/data/remote_apis/abst_remote/test_remote.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_africa_test/domain/models/test_model.dart';

final testRemoteDataSourceProvider = Provider<TestRemoteDataSource>((ref) {
  final services = ref.watch(servicesProvider);
  return TestRemoteDataSourceImpl(services: services);
});

class TestRemoteDataSourceImpl implements TestRemoteDataSource {
  final Services _services;
  TestRemoteDataSourceImpl({required Services services}) : _services = services;


  
  @override
  Future<TestModel> getTestData({required String page}) async{
   var apiRes = await _services.get(uri: "character?page=$page.");
    return TestModel.fromJson(apiRes.data);
  }
}
