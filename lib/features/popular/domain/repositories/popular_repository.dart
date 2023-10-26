import 'package:dartz/dartz.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';
import 'package:pp/features/popular/domain/useCases/popular_details.dart';

abstract class PopularRepository {
  Future<Either<Failure, BaseModel<PopularModel>>> fetchPopular(
      PopularParams params);

  Future<Either<Failure, PopularDetailsModel>> fetchPopularDetails(
      PopularDetailsParams params);
}