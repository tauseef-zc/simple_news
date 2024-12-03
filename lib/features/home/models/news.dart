class News {
  final String id;
  final String? author;
  final String title;
  final String? description;
  final String? urlToImage;
  final String? content;

  News({
    required this.id,
    this.author,
    required this.title,
    this.description,
    this.urlToImage,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['source']['id'] ?? "none",
      author: json['author'],
      title: json['title'] ?? "No Title",
      description: json['description'],
      urlToImage: json['urlToImage'] ?? "https://placehold.co/600x400.jpg?text=image",
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'content': content
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ id: $id, author: $author, title: $title, description: $description'
        'image: $urlToImage, content: $content}';
  }

}