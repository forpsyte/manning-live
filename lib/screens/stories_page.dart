import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:manning_live/stores/views_store.dart';
import 'package:mobx/mobx.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/widgets/placeholder_stories.dart';
import 'package:manning_live/widgets/story_grid_item.dart';
import 'package:manning_live/widgets/story_grid_item_alternate.dart';
import 'package:manning_live/widgets/story_headline.dart';

class StoriesPage extends StatefulWidget {
  final StoriesStore store;
  final ViewsStore viewsStore;
  StoriesPage(this.store, this.viewsStore, {Key key}) : super(key: key);

  @override
  _StoriesPageState createState() => _StoriesPageState();
}

/// Notes: use of [AutomaticKeepAliveClientMixin] with the [wantKeepAlive] override will effectively allow Flutter to retain the page state, including the scroll position.
/// Without it, switching back and forth between tabs would cause the data to tab to be rebuilt, which in turn causes data to be fetched etc
class _StoriesPageState extends State<StoriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.store.loadInitialStories();
    widget.viewsStore.loadViews();
  }

  @override
  Widget build(BuildContext context) {
    var sequence = getSequence();
    super.build(context);
    return Observer(
      builder: (_) {
        switch (widget.store.loadCollectionItemsFuture.status) {
          case FutureStatus.rejected:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Oops something went wrong'),
                  RaisedButton(
                    child: Text('Retry'),
                    onPressed: () {
                      widget.store.retry();
                    },
                  ),
                ],
              ),
            );
          case FutureStatus.fulfilled:
            return RefreshIndicator(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverFixedExtentList(
                      itemExtent: 300.0,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (widget.store.headlines.length != 0) {
                            return new Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return StoryHeadline(
                                  widget.store.headlines[index],
                                );
                              },
                              itemCount: widget.store.headlines.length,
                              viewportFraction: 1.0,
                              scale: 1.0,
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                              ),
                              autoplay: true,
                            );
                          } else {
                            return PlaceholderStories();
                          }
                        },
                        childCount: 1,
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (sequence.contains(index + 1)) {
                            return StoryGridItem(widget.store.stories[index]);
                          } else {
                            return StoryGridItemAlternate(
                                widget.store.stories[index]);
                          }
                        },
                        childCount: widget.store.stories.length,
                      ),
                    ),
                  ],
                ),
              ),
              onRefresh: () async {
                await widget.store.refresh();
              },
            );
          case FutureStatus.pending:
          default:
            return Scaffold(
              backgroundColor: Colors.amber,
              body: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              ),
            );
        }
      },
    );
  }

  List<int> getSequence() {
    var sequence = List<int>();
    sequence.add(1);
    for (var i = 1; i <= 100; i++) {
      if (i % 2 == 0) {
        sequence.add(i * 2);
        sequence.add((i * 2) + 1);
      }
    }
    return sequence;
  }

  @override
  bool get wantKeepAlive => true;
}
