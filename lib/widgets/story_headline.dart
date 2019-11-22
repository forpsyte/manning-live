import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class StoryHeadline extends StatelessWidget {
  final PostModel story;

  StoryHeadline(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    final height = 300.0;
    final images = story.getData('images');
    return InkWell(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(bottom: 8.0),
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images['medium']),
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
                  story.title,
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          )
        ],
      ),
      onTap: () async {
        await viewsStore.addView(story.getData('document_id'));
        storiesStore.setCurrentStory(story);
        Navigator.pushNamed(context, '/story');
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return Observer(
                builder: (_) => Container(
                  child: new Wrap(
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.favorite),
                        title: new Text(
                            favoritesStore.isInFavorites(story.getData('document_id'))
                                ? 'Remove from favorites'
                                : 'Add to favorites'),
                        onTap: () {
                          favoritesStore.isInFavorites(story.getData('document_id'))
                              ? favoritesStore.removeFavorite(story.getData('document_id'))
                              : favoritesStore.addFavorite(story);
                          Navigator.of(context).pop();
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.share),
                        title: new Text('Share'),
                        onTap: () async {
                          await sharingService.share(story.getData('url'));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
