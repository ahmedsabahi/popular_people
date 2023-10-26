import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';
import 'package:pp/services/dio_client.dart';

abstract class PopularRemoteDataSource {
  Future<BaseModel<PopularModel>> fetchPopular(PopularParams params);
}

final popularRemoteDataSourceImpl = Provider<PopularRemoteDataSourceImpl>(
  (ref) => PopularRemoteDataSourceImpl(ref.watch(dioClientProvider)),
);

class PopularRemoteDataSourceImpl implements PopularRemoteDataSource {
  final DioClient _dioClient;

  PopularRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseModel<PopularModel>> fetchPopular(PopularParams params) async {
    final response = await _dioClient.dio.get(
      '/person/popular',
      queryParameters: {
        'page': params.page.toString(),
      },
    );
    return BaseModel<PopularModel>.fromJson(
      response.data,
      (json) => PopularModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
