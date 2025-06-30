import 'package:dooit/common/colors.dart';
import 'package:dooit/common/fonts.dart';
import 'package:dooit/data/models/post_model.dart';
import 'package:dooit/presentation/screens/community/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/community/community_provider.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.postData, this.provider});

  final PostModel postData;
  final CommunityProvider? provider;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => PostScreen(postId: widget.postData.id),)).then((value) {
          if(widget.provider != null) {
            widget.provider!.resetPosts();
            widget.provider!.getPosts();
          }
        },);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Image.asset('assets/images/${widget.postData.authorProfile}.png'),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postData.authorName,
                      style: mediumText(size: 12, color: Colors.black),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(widget.postData.updatedAt),
                      style: mediumText(size: 10, color: greyColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  height: 23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: litePointColor,
                  ),
                  child: Text(
                    widget.postData.authorTier,
                    style: semiBoldText(size: 11, color: pointColor),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    widget.postData.title,
                    style: semiBoldText(size: 16, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: Text(widget.postData.content, style: mediumText(size: 12, color: Colors.black), overflow: TextOverflow.ellipsis, maxLines: 2,),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                _iconAndData(text: widget.postData.commentCount, icon: Icons.chat),
                SizedBox(width: 5,),
                _iconAndData(text: widget.postData.reactionCount, icon: Icons.favorite),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 1,
              color: greyColor.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconAndData({required int text, required IconData icon}) {
    return SizedBox(
      child: Row(
        children: [
          Icon(icon, size: 18, color: greyColor,),
          SizedBox(width: 3,),
          Text('${text}', style: mediumText(size: 11, color: greyColor),),
        ],
      ),
    );
  }
}
