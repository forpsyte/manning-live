import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class StoryGridItemAlternate extends StatelessWidget {
  final PostModel story;

  StoryGridItemAlternate(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    final screenSize = MediaQuery.of(context).size;
    final tileLength = screenSize.width / 2;
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        height: tileLength,
        width: tileLength,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 24.0,),
                    child: Text(
                      story.title,
                      style: Theme.of(context).accentTextTheme.headline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      story.content,
                      style: Theme.of(context).accentTextTheme.body1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: 16.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 4.0,
                            ),
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${story.getData('num_views')}",
                            style: Theme.of(context).accentTextTheme.display3,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 4.0,
                          ),
                          child: Icon(
                            Icons.comment,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${story.getData('num_comments')}",
                          style: Theme.of(context).accentTextTheme.display3,
                        )
                      ],
                    ),
                  ]),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      '${timeago.format(story.published, locale: 'en_short')}',
                      style: Theme.of(context).accentTextTheme.display3,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
