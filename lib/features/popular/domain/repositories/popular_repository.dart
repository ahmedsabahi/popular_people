import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';
import 'package:pp/features/popular/domain/useCases/popular_details.dart';
import 'package:pp/features/popular/domain/useCases/popular_images.dart';

abstract class PopularRepository {
  Future<Either<Failure, BaseModel<PopularModel>>> fetchPopular(
      PopularParams params);

  Future<Either<Failure, PopularDetailsModel>> fetchPopularDetails(
      PopularDetailsParams params);

  Future<Either<Failure, List<PopularImageModel>>> fetchPopularImages(
      PopularImagesParams params);

  Future<Either<Failure, Uint8List>> fetchPopularImage(String imgPath);
}
