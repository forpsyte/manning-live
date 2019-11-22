import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class StoryMinified extends StatelessWidget {
  final PostModel story;

  StoryMinified(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    return InkWell(
      child: Column(
        children: <Widget>[
          Divider(
            color: CupertinoColors.lightBackgroundGray,
            height: 8.0,
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            story.title,
                            style: Theme.of(context).textTheme.subhead,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                story.getData('author'),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '${timeago.format(story.published, locale: 'en')}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 88.0,
                  height: 88.0,
                  margin: EdgeInsets.only(top: 12.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(story.getImage('medium')),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
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
