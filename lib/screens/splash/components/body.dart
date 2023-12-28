import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

import '../../../services/auth.dart';
import '../../home/home_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService.userStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return HomeScreen(); // Replace this with your HomeScreen widget
          } else {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount: splashData.length,
                        itemBuilder: (context, index) =>
                            SplashContent(
                              image: splashData[index]["image"],
                              text: splashData[index]['text'],
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: Column(
                          children: <Widget>[
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                splashData.length,
                                    (index) =>
                                    AnimatedContainer(
                                      duration: kAnimationDuration,
                                      margin: const EdgeInsets.only(right: 5),
                                      height: 6,
                                      width: currentPage == index ? 20 : 6,
                                      decoration: BoxDecoration(
                                        color: currentPage == index
                                            ? kPrimaryColor
                                            : const Color(0xFFD8D8D8),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                              ),
                            ),
                            const Spacer(flex: 3),
                            DefaultButton(
                              text: "Continue",
                              press: () {
                                context.go('/SignInScreen');
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}