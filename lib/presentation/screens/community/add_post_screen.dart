import 'package:dooit/common/colors.dart';
import 'package:dooit/presentation/providers/add_post_provider.dart';
import 'package:flutter/material.dart';

import '../../../common/fonts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final AddPostProvider provider = AddPostProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFFF6EFE9),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 상단
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
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
                            await provider.createPost(context);
                          },
                          child:  Text('등록하기', style: mediumText(size: 18, color: greyColor),),
                        ),
                      ],
                    ),
                    Text('글쓰기', style: mediumText(size: 18, color: Colors.black),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: provider.titleController,
                      style: semiBoldText(size: 26, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: '제목을 입력해 주세요',
                        hintStyle: semiBoldText(size: 26, color: greyColor),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 900),
                      child: TextField(
                        controller: provider.contentController,
                        style: mediumText(size: 14, color: Colors.black),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: '내용을 작성해 보세요',
                          hintStyle: mediumText(size: 16, color: greyColor),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
