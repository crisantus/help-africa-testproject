import 'package:help_africa_test/core/constant/constants.dart';
import 'package:help_africa_test/core/exceptions/exception_code.dart';
import 'package:help_africa_test/core/exceptions/exception_type.dart';
import 'package:help_africa_test/core/exceptions/failure.dart';
import 'package:help_africa_test/core/network/network_info.dart';
import 'package:help_africa_test/data/remote_apis/abst_remote/test_remote.dart';
import 'package:help_africa_test/data/remote_apis/remote/test_remote_data.dart';
import 'package:help_africa_test/data/repository_impl/abst_repository/test_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_africa_test/domain/models/test_model.dart';

final testRepoProvider = Provider<TestRepositoryImpl>((ref) {
  final networkInfo = ref.watch(
    networkInfoProvider,
  ); // A provider for NetworkInfo
  final remoteDataSource = ref.read(
    testRemoteDataSourceProvider,
  ); // A provider for PostRemoteDataSource

  // Return the instance of PostRepoImpl
  return TestRepositoryImpl(
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
  );
});

class TestRepositoryImpl implements TestRepository {
  final NetworkInfo _networkInfo;
  final TestRemoteDataSource _remoteDataSource;

  TestRepositoryImpl({
    required NetworkInfo networkInfo,
    required TestRemoteDataSource remoteDataSource,
  }) : _networkInfo = networkInfo,
       _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure<ExceptionMessage>, TestModel>> getTestData({
    required String page,
  }) async {
    if ((await _networkInfo.isConnected)) {
      try {
        final postModel = await _remoteDataSource.getTestData(page: page);
        return right(postModel);
      } on ExceptionType<ExceptionMessage> catch (e) {
        return left(Failure.serverFailure(exception: e));
      }
    } else {
      return left(
        const Failure.serverFailure(
          exception: ExceptionMessages.NO_INTERNET_CONNECTION,
        ),
      );
    }
  }
}
