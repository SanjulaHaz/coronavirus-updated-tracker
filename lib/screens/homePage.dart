import 'package:corona_tracker/screens/mapView.dart';
import 'package:corona_tracker/screens/statsView.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController pageController;

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: 'ca-app-pub-1833552906434113/2169808433',
    targetingInfo: MobileAdTargetingInfo(
      keywords: <String>[],
      testDevices: <String>[], // Android emulators are considered test devices
    ),
  );

  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-1833552906434113/9900140556',
    size: AdSize.banner,
    targetingInfo: MobileAdTargetingInfo(
      keywords: <String>[],
      testDevices: <String>[], // Android emulators are considered test devices
    ),
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1833552906434113~9299351233");

    myBanner
      ..load()
      ..show(anchorType: AnchorType.bottom, anchorOffset: 60);

    myInterstitial
      ..load()
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          MapView(),
          StatsView(),
        ],
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: bottomItems(),
    );
  }

  BottomNavigationBar bottomItems() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xff512da8),
      onTap: (int index) {
        setState(
          () {
            currentIndex = index;
          },
        );
        pageController.animateToPage(
          index,
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeIn,
        );
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset("images/map.png"),
          ),
          title: Text("Map"),
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset("images/status.png"),
          ),
          title: Text("Stats"),
        ),
      ],
    );
  }
}
