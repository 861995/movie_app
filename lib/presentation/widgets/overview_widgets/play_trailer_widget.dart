import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/movie_provider.dart';
import '../../utils/app_const_text.dart';
import '../../utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailerWidget extends StatelessWidget {
  const PlayTrailerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openTrailer(context);
      },
      child: Row(
        children: [
          Icon(Icons.play_arrow),
          Text(
            AppConst.playTrailer,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.bold18,
          ),
        ],
      ),
    );
  }

  void openTrailer(BuildContext context) async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final videoKey = await movieProvider.findTrailer();
    if (videoKey.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YouTubePlayerExample(
            videoKey: videoKey,
          ),
        ),
      );
    }
  }
}

class YouTubePlayerExample extends StatefulWidget {
  final String videoKey;

  YouTubePlayerExample({required this.videoKey, Key? key}) : super(key: key);

  @override
  _YouTubePlayerExampleState createState() => _YouTubePlayerExampleState();
}

class _YouTubePlayerExampleState extends State<YouTubePlayerExample> {
  late YoutubePlayerController _controller;
  late String _videoId;

  @override
  void initState() {
    super.initState();
    _fetchTrailer();
  }

  Future<void> _fetchTrailer() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    if (widget.videoKey != "") {
      try {
        setState(() {
          _videoId = YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=${widget.videoKey}")!;
          _controller = YoutubePlayerController(
            initialVideoId: _videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );
        });
      } catch (e) {
        movieProvider.showToast(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Player')),
      body: _videoId.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
