import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'model/model_playlist.dart';

class PageSearch extends StatefulWidget {
  const PageSearch({Key? key}) : super(key: key);

  @override
  State<PageSearch> createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  TextEditingController searchController = TextEditingController();
  List<Datum>? playlistList;
  List<Datum>? filteredPlaylistList;
  ModelPlaylist? modelAudio;
  AudioPlayer _audioPlayer = AudioPlayer();

  // Set untuk menyimpan indeks item yang dijadikan favorit
  Set<int> _favoriteIndexes = Set<int>();

  // Method untuk get playlist
  Future<void> getPlaylist() async {
    try {
      http.Response response = await http.get(Uri.parse('http://192.168.43.45/playlist/getPlaylist.php'));
      if (response.statusCode == 200) {
        setState(() {
          playlistList = modelPlaylistFromJson(response.body).data;
          filteredPlaylistList = playlistList;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load data')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    getPlaylist();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Metode untuk menambah atau menghapus item dari set favorit
  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteIndexes.contains(index)) {
        _favoriteIndexes.remove(index);
      } else {
        _favoriteIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFCEBD0),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredPlaylistList = playlistList
                                ?.where((element) =>
                            element.judul!
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                                element.penyanyi!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('gambar/profile.png'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Albums',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'gambar/album1.png',
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "1989",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Taylor Swift')
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'gambar/album2.png',
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Lover",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Taylor Swift')
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'gambar/album4.png',
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "30",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Adele')
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'gambar/album3.png',
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Midnights",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Taylor Swift')
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'For You',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            playlistList == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredPlaylistList!.length,
              itemBuilder: (context, index) {
                Datum data = filteredPlaylistList![index];
                return Padding(
                  padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'http://192.168.43.45/playlist/gambar/${data.gambar}',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data.judul!,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    data.penyanyi!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                _favoriteIndexes.contains(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _favoriteIndexes.contains(index)
                                    ? Colors.orangeAccent
                                    : null,
                              ),
                              onPressed: () => _toggleFavorite(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              color: Colors.black,
                              onPressed: () {
                                _audioPlayer.play('http://192.168.43.45/playlist/audio/${data.file}');
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.pause),
                              color: Colors.black,
                              onPressed: () {
                                _audioPlayer.pause();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.stop),
                              color: Colors.black,
                              onPressed: () {
                                _audioPlayer.stop();
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
