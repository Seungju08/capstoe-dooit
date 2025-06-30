import 'dart:convert';

import 'package:dooit/data/models/detail_post_model.dart';
import 'package:dooit/data/models/post_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityRepository {

  final client = Client();
  final url = 'https://be-production-e1c4.up.railway.app/api';

  Future<List<PostModel>> getPosts(String keyword, int page, int size, String sort) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final queryParams = {
        'keyword': keyword,
        'page': page.toString(),
        'size': size.toString(),
        'sort': sort,
      };
      // print(queryParams);

      final response = await client.get(
          Uri.parse('${url}/community/post')
              .replace(queryParameters: queryParams),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print(jsonBody['data']);
        List<PostModel> postList = [];
        for(var post in jsonBody['data']['posts']) {
          postList.add(PostModel.fromJson(post));
        }
        print('게시글 모두 가져오기 성공!');
        return postList;
      }

      print(queryParams);
      print('게시글 모두 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return [];

    } catch(e) {
      print('게시글 모두 가져오기 에러다: $e');
      return [];
    }
  }

  Future<List<PostModel>> getPopularPosts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final queryParams = {
        'page': '1',
        'size': '10',
      };
      // print(queryParams);

      final response = await client.get(
          Uri.parse('${url}/community/post')
              .replace(queryParameters: queryParams),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print(jsonBody['data']);
        List<PostModel> postList = [];
        for(var post in jsonBody['data']['popular_posts']) {
          postList.add(PostModel.fromJson(post));
        }
        print('인기 게시글 모두 가져오기 성공!');
        return postList;
      }

      print(queryParams);
      print('인기 게시글 모두 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return [];

    } catch(e) {
      print('인기 게시글 모두 가져오기 에러다: $e');
      return [];
    }
  }

  Future<DetailPostModel?> getDetailPost(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final response = await client.get(
          Uri.parse('${url}/community/post/$id'),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        // print(jsonBody['data']);
        DetailPostModel post = DetailPostModel.fromJson(jsonBody['data']);
        print('게시글 가져오기 성공!');
        return post;
      }

      print('게시글 가져오기 실패: ${response.statusCode} ${jsonBody}');
      return null;

    } catch(e) {
      print('게시글 가져오기 에러다: $e');
      return null;
    }
  }

  Future<bool> postReaction(int id, String reaction) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final body = {
        "reaction_type": reaction,
      };

      final response = await client.post(
        Uri.parse('${url}/community/reaction/$id'),
        body: jsonEncode(body),
        headers: {
          'Authorization' : 'Bearer ${tkn}',
          'Content-Type' : 'application/json',
        },
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print('리액션 보내기 성공!');
        return true;
      }

      print('리액션 보내기 실패: ${response.statusCode} ${jsonBody}');
      return false;

    } catch(e) {
      print('리액션 보내기 에러다: $e');
      return false;
    }
  }

  Future<bool> createPost(String title, String content) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final body = {
        "title": title,
        'content': content,
      };

      final response = await client.post(
        Uri.parse('${url}/community/post'),
        body: jsonEncode(body),
        headers: {
          'Authorization' : 'Bearer ${tkn}',
          'Content-Type' : 'application/json',
        },
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print('글 쓰기 성공!');
        return true;
      }

      print('글 쓰기 실패: ${response.statusCode} ${jsonBody}');
      return false;

    } catch(e) {
      print('글 쓰기 에러다: $e');
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final response = await client.delete(
          Uri.parse('${url}/community/post/$id'),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print('게시글 삭제 성공!');
        return true;
      }

      print('게시글 삭제 실패: ${response.statusCode} ${jsonBody}');
      return false;

    } catch(e) {
      print('게시글 삭제 에러다: $e');
      return false;
    }
  }

  Future<bool> putPost(int id, String title, String content) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final tkn = pref.getString('access_token');
    try {
      final body = {
        'title': title,
        'content': content,
      };

      final response = await client.put(
          Uri.parse('${url}/community/post/$id'),
          body: jsonEncode(body),
          headers: {
            'Authorization' : 'Bearer ${tkn}'
          }
      );

      final jsonBody = await jsonDecode(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        print('게시글 수정 성공!');
        return true;
      }

      print('게시글 수정 실패: ${response.statusCode} ${jsonBody}');
      return false;

    } catch(e) {
      print('게시글 수정 에러다: $e');
      return false;
    }
  }

}