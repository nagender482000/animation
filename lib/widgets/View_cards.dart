import 'package:flutter/material.dart';
import '../screen/profile_screen.dart';
import '../model/data.dart';

// ignore: must_be_immutable
class Viewcards extends StatelessWidget {
  final int i;
  Viewcards(this.i);

  @override
  Widget build(BuildContext context) {
    var currentcard = detailList.detail[i];

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(currentcard.bgpic), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: Image.asset(
                      currentcard.profilepic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: Text(
                  currentcard.editorName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
