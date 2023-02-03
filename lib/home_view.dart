import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zarity/add_task_view.dart';
import 'package:zarity/constants.dart';
import 'package:zarity/first_view.dart';
import 'package:zarity/search_view.dart';
import 'package:zarity/user_analytics.dart';
import 'package:zarity/user_profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  final List<Widget> screens = [
    FirstView(),
    UserProfile(),
    SearchView(),
    UserAnalytics()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = FirstView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 94,
                      onPressed: () {
                        setState(() {
                          currentScreen = FirstView();
                          currentIndex = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? Colors.blueAccent
                                  : Colors.black,
                            ),
                            Text("Home",
                                style: TextStyle(
                                    color: currentIndex == 0
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 11))
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 94,
                      onPressed: () {
                        setState(() {
                          currentScreen = UserProfile();
                          currentIndex = 1;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: currentIndex == 1
                                  ? Colors.blueAccent
                                  : Colors.black,
                            ),
                            Text("Profile",
                                style: TextStyle(
                                    color: currentIndex == 1
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 11))
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 94,
                      onPressed: () {
                        setState(() {
                          currentScreen = SearchView();
                          currentIndex = 2;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: currentIndex == 2
                                  ? Colors.blueAccent
                                  : Colors.black,
                            ),
                            Text("Search",
                                style: TextStyle(
                                    color: currentIndex == 2
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 11))
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 94,
                      onPressed: () {
                        setState(() {
                          currentScreen = UserAnalytics();
                          currentIndex = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bar_chart_rounded,
                              color: currentIndex == 3
                                  ? Colors.blueAccent
                                  : Colors.black,
                            ),
                            Text("Analytics",
                                style: TextStyle(
                                    color: currentIndex == 3
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily,
                                    fontSize: 11))
                          ]),
                    ),
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     MaterialButton(
                //       minWidth: 50,
                //       onPressed: () {
                //         setState(() {
                //           currentScreen = SearchView();
                //           currentIndex = 2;
                //         });
                //       },
                //       child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.search_rounded,
                //               color: currentIndex == 2
                //                   ? Colors.blueAccent
                //                   : Colors.black,
                //             ),
                //           ]),
                //     ),
                //     MaterialButton(
                //       minWidth: 50,
                //       onPressed: () {
                //         setState(() {
                //           currentScreen = UserAnalytics();
                //           currentIndex = 3;
                //         });
                //       },
                //       child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               Icons.bar_chart_rounded,
                //               color: currentIndex == 3
                //                   ? Colors.blueAccent
                //                   : Colors.black,
                //             ),
                //           ]),
                //     ),
                //   ],
                // ),
              ],
            )),
      ),
    );
  }
}
