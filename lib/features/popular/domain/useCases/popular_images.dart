import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/usecases/use_case.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/data/repositories/popular_repository_impl.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';

final popularImagesUseCaseProvider = Provider<PopularImages>(
  (ref) => PopularImages(ref.watch(popularRepositoryImpl)),
);

class PopularImages
    implements UseCase<List<PopularImageModel>, PopularImagesParams> {
  final PopularRepository _repository;

  PopularImages(this._repository);

  @override
  Future<Either<Failure, List<PopularImageModel>>> call(
      PopularImagesParams params) async {
    return await _repository.fetchPopularImages(params);
  }
}

class PopularImagesParams {
  final int personID;

  PopularImagesParams(this.personID);
}
