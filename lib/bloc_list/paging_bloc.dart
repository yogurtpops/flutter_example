import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:example_project/bloc_list/paging_event.dart';
import 'package:example_project/bloc_list/paging_state.dart';
import 'package:example_project/object/models.dart';

class PagingListBloc extends Bloc<PagingListEvent, PagingListState> {

  int millisLoadingDelay=1500;
  List<int> loadedPage = new List<int>();
  final int totalPages = 100;
  final int limitPerPage = 10;

  setLoadingDelay(int loadingDelay){
    this.millisLoadingDelay = loadingDelay;
  }

  @override
  get initialState => PagingListUninitialized();

  @override
  Stream<PagingListState> mapEventToState(PagingListEvent event) async* {
    if (event is Fetch && !_hasReachedMax(state)) {
      print('fetch event... ${loadedPage.length}');
      try {
        if (state is PagingListUninitialized) {
          final posts = await fetchData(loadedPage.length+1);
          yield PagingListLoaded(objectlist: posts, hasReachedMax: false, stillLoading: false);
          if (posts.isNotEmpty){
            loadedPage.add(loadedPage.length+1);
          }
          return;
        } else if (state is PagingListLoaded && !(state as PagingListLoaded).stillLoading) {
          print('fetch event for loaded list... ${loadedPage.length}');

          /// show loading
          yield (state as PagingListLoaded).copyWith(stillLoading: true);

          final posts = await fetchData(loadedPage.length+1);

          /// update page number
          if (posts.isNotEmpty) {
            loadedPage.add(loadedPage.length + 1);
          }

          /// update stream
          yield posts.isEmpty
              ? (state as PagingListLoaded).copyWith(hasReachedMax: true, stillLoading: false)
              : PagingListLoaded(
              objectlist: (state as PagingListLoaded).objectlist + posts, stillLoading: false, hasReachedMax: false
          );

          print('fetch event done');
          return;
        }
      }
      catch (_) {
        yield PagingListError();
        return;
      }
    } else if (_hasReachedMax(state)){
      return;
    } else if (event is Reset){
      print('reset event...');
      loadedPage.clear();
      yield PagingListUninitialized();
      this.add(Fetch());
      return;
    }
  }

  bool _hasReachedMax(PagingListState state) =>
      state is PagingListLoaded && state.hasReachedMax;

  Future<List<Object>> fetchData(int page) async {
    await Future.delayed(Duration(milliseconds: millisLoadingDelay));

    List<Object> newObjects = List();
    for(int i=0; i<limitPerPage; i++){
      newObjects.add(ItemX(
        name: 'Item ${(page-1)*limitPerPage+i+1}',
        price: Random().nextInt(1000000)
      ));
    }

    return newObjects;
  }
}