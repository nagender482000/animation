import 'package:flutter/material.dart';
import '../screen/splash_screen.dart';
import '../widgets/View_cards.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  static const routeName = '/home';
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight);
    final double itemWidth = size.width * 1.2;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "Plants",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamed(SplashScreen.routeName);
            }),
      ),
      body: GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 1,
          mainAxisSpacing: 0,
          childAspectRatio: (itemHeight / itemWidth),
          children: [
            Viewcards(0),
            Viewcards(1),
            Viewcards(2),
            Viewcards(3),
          ]),
    );
  }
}
