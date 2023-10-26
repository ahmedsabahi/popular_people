import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/dataSources/popular_remote_data_source.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';

final popularRepositoryImpl = Provider<PopularRepositoryImpl>(
  (ref) => PopularRepositoryImpl(
    ref.watch(popularRemoteDataSourceImpl),
  ),
);

class PopularRepositoryImpl implements PopularRepository {
  final PopularRemoteDataSource _remoteDataSource;

  PopularRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, BaseModel<PopularModel>>> fetchPopular(
      PopularParams params) async {
    try {
      final response = await _remoteDataSource.fetchPopular(params);
      return Right(response);
    } catch (e) {
      return const Left(OtherFailure(message: 'Something went wrong'));
    }
  }
}
