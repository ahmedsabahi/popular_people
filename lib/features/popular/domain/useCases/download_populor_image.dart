import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/usecases/use_case.dart';
import 'package:pp/features/popular/data/repositories/popular_repository_impl.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';

final downloadPopularImageUseCaseProvider = Provider<DownloadPopularImage>(
  (ref) => DownloadPopularImage(ref.watch(popularRepositoryImpl)),
);

class DownloadPopularImage implements UseCase<Uint8List, String> {
  final PopularRepository _repository;

  DownloadPopularImage(this._repository);

  @override
  Future<Either<Failure, Uint8List>> call(String imgPath) async {
    return await _repository.fetchPopularImage(imgPath);
  }
}
