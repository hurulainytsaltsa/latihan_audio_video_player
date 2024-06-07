import 'package:audio_video_player/screen_page/player_widget.dart';
import 'package:flutter/material.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  //set url and filename
  final String urlExample =
      "http://ia802609.us.archive.org/13/items/quraninindonesia/001AlFaatihah.mp3";
  final String nameExample = "Al-Fatihah";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(nameExample),
          Container(
            margin: EdgeInsets.all(8.0),
            child: PlayerWidget(url: urlExample, fileName: nameExample),
          ),
        ],
      ),
    );
  }
}

