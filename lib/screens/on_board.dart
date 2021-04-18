import 'package:flutter/material.dart';
import 'package:kharoof_reefy/screens/main_navigation.dart';
import 'package:kharoof_reefy/widgets/on_boarding/on_boarding.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  List<String> mainTitle = ['مرحباً بك', 'مرحباً بك'];
  List<String> desc = [
    "متخصصون في (انتاج / وتربية) الخرفان الحرية",
    "تصل منازلكم مذبوحة ومقطعه ومغلفة باحترافية في عرباتنا المبردة",
  ];
  PageController _pageController;
  int currentIndex = 0;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  fun() {
    currentIndex != 1
        ? nextFunction()
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainNavigation();
                // return Home();
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _pageController,
          onPageChanged: onChangedFunction,
          children: [
            OnBoarding(
              title: mainTitle[currentIndex],
              content: desc[currentIndex],
              currentIndex: currentIndex,
              handler: fun,
            ),
            OnBoarding(
              title: mainTitle[currentIndex],
              content: desc[currentIndex],
              currentIndex: currentIndex,
              handler: fun,
            ),
          ],
        ),
      ),
    );
  }
}
