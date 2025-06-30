import 'package:dooit/common/colors.dart';
import 'package:dooit/presentation/providers/community/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/fonts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.postId});

  final int postId;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostProvider provider = PostProvider();
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.addListener(updateScreen);
      await provider.getPostData(widget.postId);
    });
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: provider.postData == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('게시글을 불러오는 중 입니다.'),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            // 게시글 파트
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await provider.deletePost(widget.postId, context);
                            },
                            child: Icon(Icons.more_vert, size: 25, color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(provider.postData!.title, style: semiBoldText(size: 30, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  // 이름
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Image.asset('assets/images/${provider.postData!.author_profile}.png'),
                      ),
                      SizedBox(width: 10,),
                      // 정보
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //티어
                          Row(
                            children: [
                              Text(provider.postData!.author_name, style: mediumText(size: 12, color: Colors.black),),
                              SizedBox(width: 5,),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: litePointColor,
                                ),
                                child: Text(
                                  provider.postData!.author_tier,
                                  style: semiBoldText(size: 8, color: pointColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Text(DateFormat('yyyy-MM-dd').format(provider.postData!.updated_at), style: mediumText(size: 12, color: greyColor),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(provider.postData!.content, style: regularText(size: 14, color: Colors.black),),
                  SizedBox(height: 15,),
                  // 감정
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _reactionButton(type: 'LIKE'),
                      _reactionButton(type: 'FUNNY'),
                      _reactionButton(type: 'SURPRISED'),
                      _reactionButton(type: 'SAD'),
                      _reactionButton(type: 'ANGRY'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              color: greyColor.withValues(alpha: 0.2),
              width: double.infinity,
              height: 15,
            ),
            //댓글
            Container(),
          ],
        ),
      ),
    ));
  }

  Widget _reactionButton({required String type}) {
    return GestureDetector(
      onTap: () async {
        await provider.sendReaction(widget.postId, type);
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/$type.png'),
              ),
              Text('${provider.postData!.reaction[type]}', style: mediumText(size: 14, color: Colors.black),),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.white.withValues(alpha: provider.postData!.my_reaction == type ? 0 : 0.5),
          ),
        ],
      ),
    );
  }

// Widget _selectSort({required String text, required VoidCallback function, bool last = false}) {
//   return GestureDetector(
//     onTap: () async {
//       final navigator = Navigator.of(context);
//       navigator.pop();
//     },
//     child: Container(
//       alignment: Alignment.center,
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           border: last ? null : Border(bottom: BorderSide(width: 1.5, color: Colors.grey.withValues(alpha: 0.5)))
//       ),
//       child: Text(text, style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: provider.sortToText() == text ? pointColor.withValues(alpha: 0.5) : Colors.black,
//       ),),
//     ),
//   );
// }

}
