import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("detailPage")));
  }
}
