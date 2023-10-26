import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/core/provider/base_provider.dart';
import 'package:pp/features/popular/data/models/popular_details_model.dart';
import 'package:pp/features/popular/domain/useCases/popular_details.dart';

final popularDetailsProvider =
    StateNotifierProvider.autoDispose<PopularDetailsProvider, ViewState>(
  (ref) => PopularDetailsProvider(
    ref.watch(popularDetailsUseCaseProvider),
  ),
);

class PopularDetailsProvider extends BaseProvider<PopularDetailsModel> {
  final PopularDetails _popularDetails;

  PopularDetailsProvider(this._popularDetails);

  Future<void> fetchPopularDetails(int personID) async {
    setLoadingState();
    final response = await _popularDetails.call(
      PopularDetailsParams(personID),
    );
    response.fold(
      (failure) => setErrorState(failure.message),
      setLoadedState,
    );
  }
}
