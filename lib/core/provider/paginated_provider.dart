import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/errors/failure.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/core/models/paginated_model.dart';
import 'package:pp/core/models/view_states.dart';

abstract class PaginatedProvider<T extends PaginatedModel>
    extends StateNotifier<ViewState> {
  PaginatedProvider(super.state);

  // Pagination Variables
  int pageNumber = 1;
  bool hasMoreData = true;

  Future<Either<Failure, BaseModel<T>>> fetchList();

  Future<void> loadMore() async {
    if (state is LoadedViewState<BaseModel<T>>) {
      final oldState = state as LoadedViewState<BaseModel<T>>;
      final oldList = oldState.data;

      final newResp = await fetchList();
      newResp.fold((failure) {
        state = LoadedViewState<BaseModel<T>>(oldList, hasMoreData: false);
      }, (newResp) {
        if (newResp.results.isNotEmpty) {
          state = LoadedViewState<BaseModel<T>>(
            oldList.copyWith(
              results: [...oldList.results, ...newResp.results],
            ),
            hasMoreData: true,
          );
        } else if (newResp.results.isEmpty) {
          state = LoadedViewState<BaseModel<T>>(newResp, hasMoreData: false);
        }
      });
    }
  }

  void resetPagination() {
    hasMoreData = true;
    pageNumber = 1;
  }

  void resetState() {
    resetPagination();
    state = InitialViewState();
  }
}
