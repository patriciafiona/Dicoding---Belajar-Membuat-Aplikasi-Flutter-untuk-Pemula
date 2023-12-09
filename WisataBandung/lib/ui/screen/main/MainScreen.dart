import 'package:flutter/material.dart';
import 'TourismPlaceGrid.dart';
import 'TourismPlaceList.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Bandung', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const TourismPlaceList();
          } else if (constraints.maxWidth <= 1200) {
            return const TourismPlaceGrid(gridCount: 4);
          } else {
            return const TourismPlaceGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}