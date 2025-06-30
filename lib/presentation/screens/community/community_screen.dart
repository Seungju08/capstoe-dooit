import 'package:dooit/common/colors.dart';
import 'package:dooit/data/models/post_model.dart';
import 'package:dooit/presentation/providers/community/community_provider.dart';
import 'package:dooit/presentation/screens/search_challenge_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/fonts.dart';
import '../../widgets/community/hot_talk_item.dart';
import '../../widgets/community/post_item.dart';
import 'add_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityProvider provider = CommunityProvider();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.addListener(updateScreen);
      provider.getPopularPosts();
      await provider.getPosts();
      provider.addList();
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: SingleChildScrollView(
        controller: provider.scrollController,
        child: Column(
          children: [
            // 상단
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'HEATH TALK',
                    style: blackText(size: 30, color: Colors.black),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) => SearchScreen(searchTarget: '커뮤니티'),));
                    },
                    child: Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Color(0xFFA6A6A6),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.notifications, color: Color(0xFFA6A6A6), size: 30),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // 이용공지
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Color(0xFFF1E7DE),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          size: 20,
                          color: Color(0xFFA6A6A6),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '다른 사용자들과 대화 해봅시다!',
                          style: mediumText(size: 12, color: Colors.black),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        '지금 HOT TALK',
                        style: semiBoldText(size: 22, color: Colors.black),
                      ),
                      Image.asset('assets/images/Fire1.png', width: 30),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // hot talk
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5),
                scrollDirection: Axis.horizontal,
                itemCount: provider.popularPosts.length,
                itemBuilder: (context, index) {
                  return provider.popularPosts.isEmpty
                      ? Text('인기 게시글이 없어요') : HotTalkItem(postData: provider.popularPosts[index],);
                },
              ),
            ),
            SizedBox(height: 32),

            // 게시글 목록
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height - 450,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(context: context, builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  Container(
                                    width: 50,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  _selectSort(text: '최신순'),
                                  _selectSort(text: '리액션 많은 순'),
                                  _selectSort(text: '댓글 많은 순', last: true),
                                ],
                              ),
                            );
                          },);
                        },
                        child: Row(
                          children: [
                            Text(provider.sortToText(), style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),),
                            Icon(Icons.arrow_drop_down, size: 20, color: Colors.black,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Column(
                    children: provider.allPosts.isEmpty
                        ? [Text('게시글이 없어요')]
                        : provider.allPosts.map((e) => PostItem(postData: e, provider: provider)).toList(),),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddPostScreen(),)).then((value) {
            provider.resetPosts();
            provider.getPosts();
          },);
        },
        child: Container(
          width: 80,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 20, color: Colors.white,),
              SizedBox(width: 2,),
              Text('만들기', style: mediumText(size: 12, color: Colors.white),),
              SizedBox(width: 7,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectSort({required String text, bool last = false}) {
    return GestureDetector(
      onTap: () async {
        print(text);
        final navigator = Navigator.of(context);
        provider.resetPosts();
        provider.setSort(text);
        await provider.getPosts();
        navigator.pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            border: last ? null : Border(bottom: BorderSide(width: 1.5, color: Colors.grey.withValues(alpha: 0.5)))
        ),
        child: Text(text, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: provider.sortToText() == text ? pointColor.withValues(alpha: 0.5) : Colors.black,
        ),),
      ),
    );
  }

}
