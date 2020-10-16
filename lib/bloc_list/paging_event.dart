

abstract class PagingListEvent {}

class Fetch extends PagingListEvent {
  @override
  String toString() => 'Fetch';
}

class Reset extends PagingListEvent {
  @override
  String toString() => 'Reset';
}
