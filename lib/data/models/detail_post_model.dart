import 'package:dooit/data/models/comment_model.dart';

class DetailPostModel {
  final int id;
  final String title;
  final String content;
  final String author_name;
  final int author_id;
  final int author_profile;
  final String author_tier;
  final DateTime created_at;
  final DateTime updated_at;
  final String? my_reaction;
  final Map<String, dynamic> reaction;
  final List<CommentModel> comments;

  DetailPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author_name,
    required this.author_id,
    required this.author_profile,
    required this.author_tier,
    required this.created_at,
    required this.updated_at,
    required this.my_reaction,
    required this.reaction,
    required this.comments,
  });

  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    List<CommentModel> commentList = [];
    for(var comment in json['comments']) {
      commentList.add(CommentModel.fromJson(comment));
    }
    DateTime create = DateTime.parse(json['created_at']);
    DateTime update = DateTime.parse(json['updated_at']);
    return DetailPostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author_name: json['author_name'],
      author_id: json['author_id'],
      author_profile: json['author_profile'],
      author_tier: json['author_tier'],
      created_at: create,
      updated_at: update,
      my_reaction: json['my_reaction'],
      reaction: json['reaction'],
      comments: commentList,
    );
  }
}
