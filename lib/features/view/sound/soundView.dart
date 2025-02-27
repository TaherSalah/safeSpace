import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';

class SoundView extends StatelessWidget {
  const SoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: MusicPlayer(),
    ));
  }
}

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String actorImageUrl =
      'assets/images/Illustration@2x.png'; // Replace with actual image URL
  String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'; // Replace with actual audio URL
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration(seconds: 1); // Prevent division by zero
  @override
  void initState() {
    super.initState();

    // Listening to the duration change (total length of the audio)
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    // Listening to the position change (current position of the audio)
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(audioUrl));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(double value) {
    _audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPosition.inSeconds.toDouble() /
        (_totalDuration.inSeconds.toDouble() == 0
            ? 1
            : _totalDuration.inSeconds.toDouble()));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          // Display actor image
          // CachedNetworkImage(
          //   imageUrl: actorImageUrl,
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          //   height: 200,
          //   width: 200,
          //   fit: BoxFit.cover,
          // ),
          Row(
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Image.asset("assets/images/Down Arrow.png")),
              Spacer(),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Image.asset("assets/images/playlist.png")),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5),
            child: TextDefaultWidget(
              title: "Calming  Playlist",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Image.asset(actorImageUrl),
          ),
          SizedBox(height: 60.h),
          // Slider(
          //   value: _currentPosition,
          //   min: 0.0,
          //   max: _totalDuration,
          //   onChanged: (value) {
          //     _seekTo(value);
          //   },
          // ),
          // **Slider Positioned Outside the Control Box**

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset("assets/images/rep.png"),
                onPressed: () {
                  // You can add skip functionality here
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  color: Color(0xffEF5DA8),
                ),
                onPressed: () {
                  // You can add skip functionality here
                },
              ),
              Center(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // الشريط الخارجي الذي يتحرك مع تشغيل الموسيقى
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: progress, // تقدم التشغيل
                          strokeWidth: 6,
                          backgroundColor: Colors.pink.withOpacity(0.2),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.pink),
                        ),
                      ),
                      // زر التشغيل/الإيقاف المؤقت في المنتصف
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink.withOpacity(0.2),
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.pink,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Color(0xffEF5DA8),
                ),
                onPressed: () {
                  // You can add skip functionality here
                },
              ),
              IconButton(
                icon: Image.asset("assets/images/Group.png"),
                onPressed: () {
                  // You can add skip functionality here
                },
              ),
            ],
          ),

          // Progress bar
        ],
      ),
    );
  }
}
