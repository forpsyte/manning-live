import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../stores/favorites_store.dart';
import '../widgets/story.dart';

class FavoritesPage extends StatefulWidget {
  final FavoritesStore store;

  const FavoritesPage(
    this.store, {
    Key key,
  }) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.store.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Observer(
      builder: (_) {
        switch(widget.store.loadFavoritesFuture.status) {
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
            if (widget.store.hasFavorites) {
              return ListView.builder(
                itemCount: widget.store.favorites.length,
                itemBuilder: (context, index) {
                  return Story(widget.store.favoritesAsStoryComponents[index]);
                },
              );
            } else {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.favorite), Text('No favorites here'),]),
              );
            }
            break;
          case FutureStatus.pending:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.favorite), Text('Loading favorites')]
              ),
            );
          default:
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
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
