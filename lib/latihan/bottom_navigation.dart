import 'package:audio_video_player/latihan/page_favorite.dart';
import 'package:audio_video_player/latihan/page_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({super.key});

  @override
  State<PageBottomNavigationBar> createState() => _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this); // Sesuaikan jumlah tab sesuai dengan widget TabBar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const [
            PageSearch(),
            PageFavorite(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF19C39),
        child: SingleChildScrollView(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Search",
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: "Favourites",
                  icon: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
