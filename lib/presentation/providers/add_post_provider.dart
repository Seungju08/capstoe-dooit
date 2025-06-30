import 'package:dooit/data/repositories/community_repository.dart';
import 'package:flutter/material.dart';

class AddPostProvider extends ChangeNotifier {
  final CommunityRepository communityRepository = CommunityRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> createPost(BuildContext context) async {
    if(await communityRepository.createPost(titleController.text, contentController.text)) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('글 작성에 실패 하였습니다.'))
      );
    }
  }
}