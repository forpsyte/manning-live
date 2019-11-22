// Copyright 2019, Justin Simon.  All rights reserved.
// Use of this source code is governed by a license
// that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manning_live/stores/search_store.dart';
import 'package:manning_live/stores/stories_store.dart';
import 'package:manning_live/stores/views_store.dart';
import 'package:manning_live/widgets/search_form.dart';
import 'package:manning_live/widgets/story.dart';
import 'package:mobx/mobx.dart';


class SearchPage extends StatefulWidget {
  final SearchStore searchStore;
  final StoriesStore storieStore;
  final ViewsStore viewsStore;
  SearchPage(this.searchStore, this.storieStore, this.viewsStore);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchText = TextEditingController(text: "");

  @override
  void initState() {
    widget.searchStore.loadSearchHistory();
    super.initState();
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Observer(
      builder: (BuildContext context) {
        if (!widget.searchStore.searchExecuted) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                SearchForm(searchText: _searchText, widget: widget),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Recent Searches',
                          style: Theme.of(context).accentTextTheme.subhead,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text("Clear",
                            style: Theme.of(context).accentTextTheme.button),
                        onTap: () {
                          widget.searchStore.clearSearchHistory();
                        },
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.searchStore.searchHistory.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          height: 25.0,
                          duration: Duration(seconds: 1),
                          child: Material(
                            child: InkWell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      widget.searchStore.searchHistory[index],
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  widget.searchStore.search(
                                      widget.searchStore.searchHistory[index]);
                                }),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
        switch (widget.searchStore.loadresultItemsFuture.status) {
          case FutureStatus.rejected:
            return SafeArea(
              child: Column(
                children: <Widget>[
                  SearchForm(searchText: _searchText, widget: widget),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Oops something went wrong'),
                        RaisedButton(
                          child: Text('Retry'),
                          onPressed: () {
                            widget.searchStore
                                .search(widget.searchStore.previousQuery);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          case FutureStatus.fulfilled:
            _searchText.text = widget.searchStore.previousQuery;
            if (widget.searchStore.results.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SearchForm(searchText: _searchText, widget: widget),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: 200),
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.search,
                            size: 150,
                            color: CupertinoColors.lightBackgroundGray,
                          ),
                        ),
                        Container(
                          child: Text(
                            'No search results',
                            style: Theme.of(context).textTheme.display2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100.0, 8.0, 100.0, 0),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints.expand(width: 225, height: 100),
                            child: Text(
                              'No search results found. Please revise your search and try again',
                              style: Theme.of(context).accentTextTheme.subhead,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return SafeArea(
              child: Column(
                children: <Widget>[
                  SearchForm(searchText: _searchText, widget: widget),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                          child: Text(
                            '${widget.searchStore.results.length} ${widget.searchStore.results.length == 1 ? 'result' : 'results'}',
                            style: Theme.of(context).accentTextTheme.subhead,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.searchStore.results.length,
                      itemBuilder: (context, index) {
                        return Story(widget.searchStore.results[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          case FutureStatus.pending:
          default:
            return SafeArea(
              child: Column(
                children: <Widget>[
                  SearchForm(searchText: _searchText, widget: widget),
                ],
              ),
            );
        }
      },
    );
  }
}