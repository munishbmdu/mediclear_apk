import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'graph_test.dart';
import 'graph_test2.dart';

class ViewGraph extends StatefulWidget {
  const ViewGraph({Key? key}) : super(key: key);

  @override
  State<ViewGraph> createState() => _ViewGraphState();
}

class _ViewGraphState extends State<ViewGraph> {
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: content()),
    );
  }

  Widget content() {
    return Container(
      child: CustomLineChart(
        points: pricePoints,
        onPointClicked: (x) {
          if (x == 10) {
            print("Clicked on $x");
          } else if (x == 8) {
            playSound();
          } else if (x == 6) {
            playSound();
          } else if (x == 4) {
            playSound();
          }
        },
      ),
    );
  }

  Future<void> playSound() async {
    try {
      await player.setAsset('assets/feq.mp3');
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }
}
