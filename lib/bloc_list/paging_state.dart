abstract class PagingListState {
  PagingListState([List props = const []]) : super();
}

class PagingListUninitialized extends PagingListState {
  @override
  String toString() => 'PostUninitialized';
}

class PagingListError extends PagingListState {

  final int errorCode;

  PagingListError({this.errorCode}) : super([errorCode]);

  @override
  String toString() => 'PostError { errorCode : ${errorCode}';
}

class PagingListLoaded extends PagingListState {
  final List<Object> objectlist;
  final bool hasReachedMax;
  final bool stillLoading;

  PagingListLoaded({
    this.stillLoading,
    this.objectlist,
    this.hasReachedMax,
  }) : super([stillLoading, objectlist, hasReachedMax]);

  PagingListLoaded copyWith({
    List<Object> posts,
    bool hasReachedMax,
    bool stillLoading,
  }) {
    return PagingListLoaded(
      objectlist: posts ?? this.objectlist,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      stillLoading: stillLoading ?? this.stillLoading,
    );
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${objectlist.length}, hasReachedMax: $hasReachedMax, stillLoading: $stillLoading }';
}