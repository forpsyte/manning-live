// Copyright 2019, Justin Simon.  All rights reserved.
// Use of this source code is governed by a license 
// that can be found in the LICENSE file.

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html_unescape/html_unescape.dart';

// A StoryComponent is used to leverage and transform
// the [DocumentSnapshot] class so that it can be used for
// storing user preferences.
class StoryComponent {

  final String author;
  final String content;
  final String documentId;
  final Map<dynamic, dynamic> images;
  final int numComments;
  final int numViews;
  final int publishedAt;
  final String title;
  final String url;
  static final HtmlUnescape _unescape = new HtmlUnescape();

  DateTime get published => new DateTime.fromMicrosecondsSinceEpoch(publishedAt);

  String getImage(String key) {
    return this.images[key];
  }

  List<String> getContent() {
    var sections = this.content.split("\n");
    sections.removeWhere((test) => test == "" || test == "\n");
    return sections;
  }

  StoryComponent.fromSnapshot(DocumentSnapshot document) :
    this.author = document['author'],
    this.content = _unescape.convert(document['content']),
    this.documentId = document.documentID,
    this.images = document['images'],
    this.numComments = document['num_comments'],
    this.numViews = document['num_views'],
    this.publishedAt = document['published_at'].toDate().microsecondsSinceEpoch,
    this.title = _unescape.convert(document['title']),
    this.url = document['url'];

  StoryComponent.fromJson(Map<String, dynamic> json) :
    this.author = json['author'],
    this.content = json['content'],
    this.documentId = json['documentId'],
    this.images = json['images'],
    this.numComments = json['num_comments'],
    this.numViews = json['num_views'],
    this.publishedAt = json['published_at'],
    this.title = json['title'],
    this.url = json['url'];

  StoryComponent.fromAlgoliaQuerySnapshot(Map<String, dynamic> query) :
    this.author = query['author'],
    this.content = _unescape.convert(query['content']),
    this.documentId = query['objectID'],
    this.images = query['images'],
    this.numComments = query['num_comments'],
    this.numViews = query['num_views'],
    this.publishedAt = new DateTime.fromMicrosecondsSinceEpoch(query['published_at']['_seconds'] * 1000000).microsecondsSinceEpoch,
    this.title = _unescape.convert(query['title']),
    this.url = query['url'];
  
  Map<String, dynamic> toJson() =>
    {
      'author': author,
      'content': content,
      'documentId': documentId,
      'numComments': numComments,
      'numViews': numViews,
      'publishtAt': publishedAt,
      'title': title,
      'url': url
    };
}