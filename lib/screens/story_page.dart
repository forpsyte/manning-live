import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';

class StoryPage extends StatefulWidget {
  final FavoritesStore favoritesStore;
  final StoriesStore storiesStore;

  StoryPage(this.favoritesStore, this.storiesStore, {Key key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    final content = widget.storiesStore.currentStory.getContent();
    final height = 300.0;
    return Observer(
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.amber,
          //   elevation: 0,
          // ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(bottom: 8.0),
                          height: height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.storiesStore.currentStory.getImage('medium')),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          // margin: EdgeInsets.only(bottom: 8.0),
                          height: height,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: NetworkImage(story.listImage),
                            //   fit: BoxFit.cover,
                            // ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black12.withAlpha(0),
                                Colors.black38.withAlpha(0),
                                Colors.black45.withAlpha(20),
                                Colors.black87.withAlpha(180),
                                Colors.black
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 40.0),
                          height: height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                widget.storiesStore.currentStory.title,
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: index == content.length - 1
                          ? EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 120.0)
                          : EdgeInsets.all(10.0),
                      child: Text(content[index],
                          style: Theme.of(context).primaryTextTheme.body1,
                          strutStyle: StrutStyle(height: 1.3)),
                    );
                  },
                  childCount: content.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
