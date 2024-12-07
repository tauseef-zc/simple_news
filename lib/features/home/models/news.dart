import 'dart:math';

import 'package:jiffy/jiffy.dart';

class News {
  final int id;
  final String title;
  final String? description;
  final String? source;
  final String? author;
  final String urlToImage;
  final String? url;
  final String? content;
  final DateTime publishedAt;
  bool? isSaved;

  News({
    required this.id,
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
    this.author,
    this.source,
    this.description,
    this.url,
    this.content,
    this.isSaved
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      // generate a unique id for each news item in the database,
      id: json['id'] ?? Random().nextInt(10000),
      author: json['author'],
      source: json['source']['name'] ?? "",
      title: json['title'] ?? "",
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'] ?? "https://placehold.co/200x200.jpg?text=image",
      content: json['content'],
      publishedAt: DateTime.parse(json['publishedAt']),
      isSaved: json['isSaved'] ?? false,
    );
  }

  factory News.fromMap(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      author: json['author'],
      source: json['source'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'] ?? "https://placehold.co/200x200.jpg?text=image",
      content: json['content'],
      publishedAt: DateTime.parse(json['publishedAt']),
      isSaved: json['isSaved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'source': source,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
      'content': content,
      'publishedAt': Jiffy.parseFromDateTime(publishedAt).format(pattern: "yyyy-MM-dd HH:mm:ss"),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'source': source,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'url': url,
      'content': content,
      'publishedAt': Jiffy.parseFromDateTime(publishedAt).format(pattern: "yyyy-MM-dd HH:mm:ss"),
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ id: $id, author: $author, title: $title, description: $description'
        'image: $urlToImage, content: $content}';
  }

}