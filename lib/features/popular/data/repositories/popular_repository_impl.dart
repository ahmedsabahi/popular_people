import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/dataSources/popular_remote_data_source.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';
import 'package:pp/features/popular/domain/useCases/popular_details.dart';
import 'package:pp/features/popular/domain/useCases/popular_images.dart';

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

  @override
  Future<Either<Failure, PopularDetailsModel>> fetchPopularDetails(
      PopularDetailsParams params) async {
    try {
      final response = await _remoteDataSource.fetchPopularDetails(params);
      return Right(response);
    } catch (e) {
      return const Left(OtherFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<PopularImageModel>>> fetchPopularImages(
      PopularImagesParams params) async {
    try {
      final response = await _remoteDataSource.fetchPopularImages(params);
      return Right(response);
    } catch (e) {
      return const Left(OtherFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> fetchPopularImage(String imgPath) async {
    try {
      final response = await _remoteDataSource.fetchPopularImage(imgPath);
      return Right(response);
    } catch (e) {
      return const Left(OtherFailure(message: 'Something went wrong'));
    }
  }
}
