import 'package:example_project/bloc_list/paging_bloc.dart';
import 'package:example_project/bloc_list/paging_event.dart';
import 'package:example_project/bloc_list/paging_state.dart';
import 'package:example_project/object/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NestedListviewDemo extends StatefulWidget {
  NestedListviewDemo({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return NestedListviewDemoState();
  }

}

class NestedListviewDemoState extends State<NestedListviewDemo> {
  PagingListBloc _postBloc;
  final _scrollThreshold = 0.0;
  final scrollController = ScrollController();

  void _onScroll() {
    if ((_postBloc.state is PagingListLoaded) && !(_postBloc.state as PagingListLoaded).stillLoading){
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        _postBloc.add(Fetch());
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _postBloc = PagingListBloc();
    _postBloc.add(Fetch());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Good Nested Listview Example"),
        ),
        body: CustomScrollView(
          controller: scrollController,
          slivers:[
            SliverToBoxAdapter(
              child: Container(
                height: 150,
                child: Center(
                  child: Text("Header"),
                ),
              ),
            ),
            BlocBuilder(
                bloc: _postBloc,
                builder: (c, state) {
                  return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (state is PagingListUninitialized) {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),),
                          );
                        } else if (state is PagingListError) {
                          print("object error");
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is PagingListLoaded) {
                          if (state.objectlist.isEmpty) {
                            return Container(
                              padding: EdgeInsets.only(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  top: 16),
                              child: Center(
                                child: Text('error'),
                              ),
                            );
                          }
                          else if (index>=state.objectlist.length) {
                            print('loading............');
                            return Container(
                              height: 60,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Container(
                              height: 80,
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(28),
                                      // height: 15,
                                      child: Center(child: Text("${(state.objectlist[index] as ItemX).name}"))),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            );
                          }
                        }
                      },
                    childCount:
                    !(state is PagingListLoaded) ? 1
                        : !state.hasReachedMax && state.stillLoading
                        ? state.objectlist.length + 1
                        : state.objectlist.length
                  ));
            }
            ),
          ],
        )
    );
  }
}