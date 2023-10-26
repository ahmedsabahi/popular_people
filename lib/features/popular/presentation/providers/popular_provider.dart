import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/core/provider/paginated_provider.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/domain/useCases/popular.dart';

final popularProvider =
    StateNotifierProvider.autoDispose<PopularProvider, ViewState>(
  (ref) => PopularProvider(
    ref.watch(popularUseCaseProvider),
  )..fetchPopular(),
);

class PopularProvider extends PaginatedProvider<PopularModel> {
  final Popular _popular;

  PopularProvider(this._popular) : super(InitialViewState());

  Future<void> fetchPopular() async {
    state = LoadingViewState();
    final response = await fetchList();
    response.fold(
      (failure) => state = ErrorViewState(failure.message),
      (success) => success.results.isNotEmpty
          ? state = LoadedViewState(success)
          : state = EmptyViewState(),
    );
  }

  @override
  Future<Either<Failure, BaseModel<PopularModel>>> fetchList() {
    return _popular.call(
      PopularParams(page: pageNumber++),
    );
  }
}
