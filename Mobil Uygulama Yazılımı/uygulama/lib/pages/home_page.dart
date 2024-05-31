import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/material.dart";
import "package:uygulama/pages/map_view_page.dart";

import "data_page.dart";
import "main_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 1;

  late int _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  final DataPage _dataPage = const DataPage();
  final MainPage _mainPage = const MainPage();
  final MapViewPage _mapViewPage = const MapViewPage();

  late List screens = [
    _dataPage,
    //const ConnectPage(),
    _mainPage,
    _mapViewPage,
    //const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 1;
    _pages = [
      _dataPage,
      //const ConnectPage(),
      _mainPage,
      _mapViewPage,
      //const SettingsPage(),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade600,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            // appBar: AppBar(
            //   backgroundColor: Colors.deepPurple.shade600,
            //   centerTitle: true,
            //   leading: const Icon(Icons.menu, color: Colors.white),
            //   actions: const [Icon(Icons.more_vert, color: Colors.white)],
            //   title:
            //       const Text('Uygulama', style: TextStyle(color: Colors.white)),
            // ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
            bottomNavigationBar: CurvedNavigationBar(
              height: 60,
              index: _selectedPageIndex,
              onTap: (index) {
                setState(() {
                  _selectedPageIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              backgroundColor: Colors.transparent,
              color: Theme.of(context).primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              items: const [
                Icon(Icons.query_stats, color: Colors.white, size: 32),
                //Icon(Icons.wifi, color: Colors.white),
                Icon(Icons.home, color: Colors.white, size: 32),
                Icon(Icons.location_on, color: Colors.white, size: 32),
                //Icon(Icons.settings, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
