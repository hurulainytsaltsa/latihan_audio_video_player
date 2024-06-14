import 'package:audio_video_player/latihan/video_player_page.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_player/latihan/page_favorite.dart';
import 'package:audio_video_player/latihan/page_search.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<PageBottomNavigationBar> createState() => _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar> with SingleTickerProviderStateMixin {
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            PageSearch(),
            PageFavorite(),
            VideoListPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF19C39),
        child: SingleChildScrollView(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              tabs: [
                Tab(
                  text: "Search",
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: "Favorites",
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  text: "Video",
                  icon: Icon(Icons.video_camera_back_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
