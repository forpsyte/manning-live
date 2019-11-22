import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/services/firebase/firestore/factory/model/post_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:manning_live/services/system/sharing_service.dart';
import 'package:manning_live/stores/favorites_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';

import 'styles.dart';

class Story extends StatelessWidget {
  final PostModel story;
  
  Story(this.story, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharingService = Provider.of<SharingService>(context);
    final favoritesStore = Provider.of<FavoritesStore>(context);
    final viewsStore = Provider.of<ViewsStore>(context);
    final storiesStore = Provider.of<StoriesStore>(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
        child: Row(
          children: [
            Center(
              child: CircleAvatar(
                child: Center(
                  child: Text(
                    "${story.getData('num_views')}",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSpacer(
                      Text(
                        story.title,
                        style: Theme.of(context).textTheme.subhead
                      ),
                    ),
                    TextSpacer(
                      Text(
                        story.getData('url'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                    TextSpacer(
                      Text(
                        '${story.getData('author')} - ${timeago.format(story.published, locale: 'en')}',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                    Text(
                      '${story.getData('num_comments')} ${story.getData('num_comments') == 1 ? 'comment' : 'comments'}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
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
          }
        );
      },
    );
  }
}
