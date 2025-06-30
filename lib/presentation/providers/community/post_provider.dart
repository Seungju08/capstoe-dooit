import 'package:dooit/data/models/detail_post_model.dart';
import 'package:dooit/data/repositories/community_repository.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final CommunityRepository communityRepository = CommunityRepository();
  DetailPostModel? postData;

  Future<void> getPostData(int id) async {
    postData = await communityRepository.getDetailPost(id);
    notifyListeners();
  }

  Future<void> sendReaction(int id, String reaction) async {
    await communityRepository.postReaction(id, reaction);
    await getPostData(id);
    notifyListeners();
  }

  Future<void> deletePost(int id, BuildContext context) async {
    if(await communityRepository.deletePost(id)) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시글을 삭제하지 못했습니다'))
      );
    }
  }

}