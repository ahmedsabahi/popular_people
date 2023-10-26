import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/core/provider/base_provider.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/domain/useCases/popular_images.dart';

final popularImagesProvider =
    StateNotifierProvider.autoDispose<PopularImagesProvider, ViewState>(
  (ref) => PopularImagesProvider(
    ref.watch(popularImagesUseCaseProvider),
  ),
);

class PopularImagesProvider extends BaseProvider<List<PopularImageModel>> {
  final PopularImages _popularImages;

  PopularImagesProvider(this._popularImages);

  Future<void> fetchPopularImages(int personID) async {
    setLoadingState();
    final response = await _popularImages.call(
      PopularImagesParams(personID),
    );
    response.fold(
      (failure) => setErrorState(failure.message),
      setLoadedState,
    );
  }
}
