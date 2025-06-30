import 'package:dooit/data/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../../data/models/challenge/challenge_list_model.dart';
import '../../data/models/challenge/view_challenge_model.dart';
import '../../data/repositories/challenge_repository.dart';
import '../../data/repositories/community_repository.dart';

class SearchChallengeProvider extends ChangeNotifier {
  final CommunityRepository communityRepository = CommunityRepository();
  final ChallengeRepository challengeRepository = ChallengeRepository();
  final TextEditingController keywordController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  ChallengeListModel? challengesData;
  List<ViewChallengeModel> challenges = [];
  List<PostModel> allPosts = [];
  List<PostModel> posts = [];
  int page = 0;
  bool havePost = false;

  String buttonText = '';
  String searchHintText = '';
  String nothingText = '';

  void setTexts(String searchTarget) {
    searchHintText = searchTarget == '챌린지' ? '챌린지 이름을 검색해보세요' : '글 내용 혹은 제목을 검색해보세요';
    buttonText = searchTarget == '챌린지' ? '챌린지 만들기' : '글 쓰러 가기';
    nothingText = searchTarget == '챌린지'
        ? '과 관련한 챌린지를 찾을 수 없어요.\n직접 만들어 보세요!'
        : '과 관련한 글을 찾을 수 없어요.\n직접 글을 써보세요!';
    notifyListeners();
  }

  void resetKeyword() {
    keywordController.text = '';
    notifyListeners();
  }

  void resetList(String searchTarget) {
    if(searchTarget == '챌린지') {
      _resetChallenges();
    } else {
      _resetPosts();
    }
  }
  void _resetChallenges() {
    challenges = [];
    challengesData = null;
    page = 0;
    notifyListeners();
  }
  void _resetPosts() {
    allPosts = [];
    page = 0;
    havePost = false;
    notifyListeners();
  }


  void addList(String searchTarget) {
    if(searchTarget == '챌린지') {
      _addChallengeList();
    } else {
      _addPostList();
    }
  }
  void _addChallengeList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 300 &&
          !challengesData!.last) {
        page += 1;
        await _getChallengesData();
      }
    });
  }
  void _addPostList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 300 &&
          posts.isNotEmpty) {
        page += 1;
        await _getPostsData();
      }
    });
  }

  Future<void> getData(String searchTarget) async {
    if(searchTarget == '챌린지') {
      _getChallengesData();
    } else {
      _getPostsData();
    }
  }
  Future<void> _getChallengesData() async {
    if(keywordController.text.isNotEmpty) {
      challengesData = await challengeRepository.getChallengeList(
        '',
        keywordController.text,
        page,
        10,
        '',
      );
      if (challengesData != null && challengesData!.content.isNotEmpty) {
        challenges.addAll(challengesData!.content);
      }
    }
    notifyListeners();
  }
  Future<void> _getPostsData() async {
    posts = await communityRepository.getPosts(keywordController.text, page, 10, '');
    if(posts.isNotEmpty) {
      allPosts.addAll(posts);
    }
    havePost = true;
    notifyListeners();
  }

  String check(String target) {
    if(target == '챌린지') {
      if(challengesData == null) {
        return keywordController.text.isEmpty ? '빈상자' : '기다리기';
      } else {
        return challengesData!.total_elements == 0 ? '없습니다' : '결과값';
      }
    } else if(posts.isEmpty) {
      return keywordController.text.isEmpty ? '빈상자' : havePost ? '없습니다' : '기다리기';
    } else {
      return !havePost ? '없습니다' : '결과값';
    }
  }

}