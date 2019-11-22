import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class StoryGridItem extends StatelessWidget {
  final PostModel story;

  StoryGridItem(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    final screenSize = MediaQuery.of(context).size;
    final tileLength = screenSize.width / 2;
    final images = story.getData('images');
    return InkWell(
      child: Container(
        height: tileLength,
        width: tileLength,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(images['medium']),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              height: tileLength / 2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        story.title,
                        style: Theme.of(context).textTheme.headline,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
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
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${story.getData('num_views')}",
                                  style: Theme.of(context).textTheme.display3,
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
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${story.getData('num_comments')}",
                                style: Theme.of(context).textTheme.display3,
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
                            style: Theme.of(context).textTheme.display3,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
