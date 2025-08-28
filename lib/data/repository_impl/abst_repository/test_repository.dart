

import 'package:help_africa_test/core/exceptions/exception_code.dart';
import 'package:help_africa_test/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:help_africa_test/domain/models/test_model.dart';


abstract class TestRepository {

  Future<Either<Failure<ExceptionMessage>, TestModel>> getTestData({required String page});

}