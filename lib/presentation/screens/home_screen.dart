import 'package:dooit/data/modles/user_data.dart';
import 'package:dooit/data/repositories/user_repository.dart';
import 'package:dooit/presentation/screens/alarm_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserRepository userRepository = UserRepository();

  void handleTap(int index) {
    switch (index) {
      case 0:
        // _launchURL(url0);
        break;
      case 1:
        // _launchURL(url1);
        break;
      case 2:
        // _launchURL(url2);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userRepository.userInfo();
    });
    // userRepository.getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6EFE9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home_screen_title.png',
                    width: 250,
                    height: 100,
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xffF1E7DE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/glowing_star.png',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        Text(
                          '개',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AlarmScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Image.asset(
                  'assets/images/timer_bg.png',
                  width: 350,
                  height: 350,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(userData.name.toString())],
                ),
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 190,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/calendar.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 190,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color(0xff5D29CC),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/biceps.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '입실하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            CustomSwiper(
              items: List.generate(4, (index) {
                return Image.asset(
                  'assets/images/banner${index + 1}.png',
                  fit: BoxFit.cover,
                );
              }),
              height: 100,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              onTap: (index) => handleTap(index),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이번 주 운동 시간',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '00m 00s',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 43,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '이번 주 운동 기록이 없어요😫',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: 'Prendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 55),
                      Container(
                        width: 150,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '운동 분석 보기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [7, 5],
                      strokeWidth: 1.3,
                      radius: Radius.circular(20),
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 40,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('월'),
                  Text('화'),
                  Text('수'),
                  Text('목'),
                  Text('금'),
                  Text('토'),
                  Text('일'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('23'),
                  Text('24'),
                  Text('25'),
                  Text('26'),
                  Text('27'),
                  Text('28'),
                  Text('29'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/chart.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text('하루 평균 운동 시간'),
                    Spacer(),
                    Text(
                      '운동 기록이 없어요',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/fire.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text('하루 최대 운동 시간'),
                    Spacer(),
                    Text(
                      '운동 기록이 없어요',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// onTap: () {
// showModalBottomSheet(
// context: context,
// barrierColor: Colors.black.withOpacity(0.4),
// isScrollControlled: true,
// backgroundColor: Colors.white,
// builder: (context) {
// return StatefulBuilder(
// builder: (context, setState) {
// return Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// SizedBox(height: 20),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20,
// ),
// child: Row(
// children: [
// Text(
// '알림',
// style: TextStyle(
// color: Colors.black,
// fontSize: 25,
// fontFamily: 'Pretendard',
// fontWeight: FontWeight.w700,
// ),
// ),
// Spacer(),
// GestureDetector(
// onTap: () {
// Navigator.pop(context);
// },
// child: Icon(
// Icons.cancel_outlined,
// size: 30,
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: 20),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20,
// ),
// child: Container(
// width: double.infinity,
// height: 55,
// color: Colors.grey.shade50,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10,
// ),
// child: Row(
// children: [Text('오늘 최고 기록: 300분')],
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20,
// ),
// child: Container(
// width: double.infinity,
// height: 55,
// color: Colors.grey.shade50,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10,
// ),
// child: Row(
// children: [Text('오늘 최고 기록: 300분')],
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20,
// ),
// child: Container(
// width: double.infinity,
// height: 55,
// color: Colors.grey.shade50,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10,
// ),
// child: Row(
// children: [Text('오늘 최고 기록: 300분')],
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20,
// ),
// child: Container(
// width: double.infinity,
// height: 55,
// color: Colors.grey.shade50,
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 10,
// ),
// child: Row(
// children: [Text('오늘 최고 기록: 300분')],
// ),
// ),
// ),
// ),
// SizedBox(height: 40),
// ],
// );
// },
// );
// },
// );
// },
