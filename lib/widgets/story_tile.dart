import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

class StoryTile extends StatelessWidget {
  final PostModel story;

  StoryTile(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        height: 150.0,
        margin: EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      DateFormat("MM.dd.yy").format(story.published),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.black,
                    width: 3.0,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125.0,
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 125.0,
                          height: 125.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(story.getImage('medium')),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
                      height: 125.0,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            story.title,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                story.getData('author'),
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Icon(
                                Icons.add_circle_outline,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
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
