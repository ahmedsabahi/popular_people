import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/usecases/use_case.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/data/repositories/popular_repository_impl.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';

final popularDetailsUseCaseProvider = Provider<PopularDetails>(
  (ref) => PopularDetails(ref.watch(popularRepositoryImpl)),
);

class PopularDetails
    implements UseCase<PopularDetailsModel, PopularDetailsParams> {
  final PopularRepository _repository;

  PopularDetails(this._repository);

  @override
  Future<Either<Failure, PopularDetailsModel>> call(
      PopularDetailsParams params) async {
    return await _repository.fetchPopularDetails(params);
  }
}

class PopularDetailsParams {
  final int personID;

  PopularDetailsParams(this.personID);
}
