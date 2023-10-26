abstract class ViewState {}

class InitialViewState implements ViewState {}

class LoadingViewState implements ViewState {}

class ErrorViewState implements ViewState {
  ErrorViewState(this.errorMessage);
  final String errorMessage;
}

class EmptyViewState implements ViewState {}

class LoadedViewState<T extends Object> implements ViewState {
  LoadedViewState(
    this.data, {
    this.hasMoreData = true,
  });

  final T data;
  final bool? hasMoreData;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedViewState<T> &&
        other.data == data &&
        other.hasMoreData == hasMoreData;
  }

  @override
  int get hashCode => data.hashCode ^ hasMoreData.hashCode;

  @override
  String toString() =>
      'LoadedViewState(data: $data, hasMoreData: $hasMoreData)';

  LoadedViewState<T> copyWith({
    T? data,
    bool? hasMoreData,
  }) {
    return LoadedViewState<T>(
      data ?? this.data,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}
