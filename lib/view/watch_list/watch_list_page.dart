import 'package:flutter/material.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch List')),
      body: const Center(child: Text('This is the Watch List Page')),
    );
  }
}
