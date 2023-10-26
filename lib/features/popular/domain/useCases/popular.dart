import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/core/usecases/use_case.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/data/repositories/popular_repository_impl.dart';
import 'package:pp/features/popular/domain/repositories/popular_repository.dart';

final popularUseCaseProvider = Provider<Popular>(
  (ref) => Popular(ref.watch(popularRepositoryImpl)),
);

class Popular implements UseCase<BaseModel<PopularModel>, PopularParams> {
  final PopularRepository _repository;

  Popular(this._repository);

  @override
  Future<Either<Failure, BaseModel<PopularModel>>> call(
      PopularParams params) async {
    return _repository.fetchPopular(params);
  }
}

class PopularParams {
  final int page;

  PopularParams({required this.page});
}
