import 'package:flutter/material.dart';

class WatchVideosScreen extends StatelessWidget{
  const WatchVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Videos'),),body: const Center(child: Text('No videos found'),),);
  }
}
