// Copyright 2019, Justin Simon.  All rights reserved.
// Use of this source code is governed by a license
// that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:manning_live/screens/search_page.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key key,
    @required TextEditingController searchText,
    @required this.widget,
  })  : _searchText = searchText,
        super(key: key);

  final TextEditingController _searchText;
  final SearchPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
            decoration:
                BoxDecoration(color: CupertinoColors.lightBackgroundGray),
            child: CupertinoTextField(
              controller: _searchText,
              autofocus: false,
              enableInteractiveSelection: true,
              prefix: Icon(
                Icons.search,
                color: CupertinoColors.lightBackgroundGray,
              ),
              textInputAction: TextInputAction.search,
              clearButtonMode: OverlayVisibilityMode.editing,
              style: Theme.of(context).textTheme.display1,
              placeholderStyle: Theme.of(context).accentTextTheme.subtitle,
              placeholder: "Find it on Manning Live...",
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
              onSubmitted: (text) =>
                  widget.searchStore.search(_searchText.text),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: CupertinoColors.lightBackgroundGray),
          child: SizedBox(
            width: 70.0,
            height: 50.0,
            child: FlatButton(
              // pressedOpacity: 0.3,
              // shape: ,
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              color: CupertinoColors.lightBackgroundGray,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.right,
                ),
              ),
              onPressed: () {
                if (widget.searchStore.searchExecuted) {
                  widget.searchStore.clearSearchResults();
                  _searchText.text = "";
                }
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
      ],
    );
  }
}