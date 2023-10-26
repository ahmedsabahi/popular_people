import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';
import 'package:pp/features/popular/domain/useCases/popular_details.dart';
import 'package:pp/features/popular/domain/useCases/popular_images.dart';
import 'package:pp/services/dio_client.dart';
import 'package:pp/utils/constants.dart';

abstract class PopularRemoteDataSource {
  Future<BaseModel<PopularModel>> fetchPopular(PopularParams params);
  Future<PopularDetailsModel> fetchPopularDetails(PopularDetailsParams params);
  Future<List<PopularImageModel>> fetchPopularImages(
      PopularImagesParams params);
  Future<Uint8List> fetchPopularImage(String imgPath);
}

final popularRemoteDataSourceImpl = Provider<PopularRemoteDataSourceImpl>(
  (ref) => PopularRemoteDataSourceImpl(ref.watch(dioClientProvider)),
);

class PopularRemoteDataSourceImpl implements PopularRemoteDataSource {
  final DioClient _dioClient;

  PopularRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseModel<PopularModel>> fetchPopular(PopularParams params) async {
    final res = await _dioClient.dio.get(
      '/person/popular',
      queryParameters: {
        'page': params.page.toString(),
      },
    );
    return BaseModel<PopularModel>.fromJson(
      res.data,
      (json) => PopularModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<PopularDetailsModel> fetchPopularDetails(
      PopularDetailsParams params) async {
    final res = await _dioClient.dio.get('/person/${params.personID}');
    return PopularDetailsModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<List<PopularImageModel>> fetchPopularImages(
      PopularImagesParams params) async {
    final res = await _dioClient.dio.get("/person/${params.personID}/images");
    return (res.data['profiles'] as List<dynamic>)
        .map((e) => PopularImageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Uint8List> fetchPopularImage(String imgPath) async {
    final response = await _dioClient.dio.get(
      AppConstants.kImageBaseUrl + imgPath,
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }
}
