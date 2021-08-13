import 'package:flutter/material.dart';
import 'package:nagender_singh/bloc/state_bloc.dart';
import 'package:nagender_singh/bloc/state_provider.dart';
import 'package:nagender_singh/model/data.dart';

class ProfileDetailsAnimation extends StatefulWidget {
  @override
  _ProfileDetailsAnimationState createState() =>
      _ProfileDetailsAnimationState();
}

class _ProfileDetailsAnimationState extends State<ProfileDetailsAnimation>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  AnimationController scaleController;

  Animation fadeAnimation;
  Animation scaleAnimation;

  @override
  void initState() {
    super.initState();

    fadeController =
        AnimationController(duration: Duration(milliseconds: 180), vsync: this);

    scaleController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this);

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeController);
    scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));
  }

  forward() {
    scaleController.forward();
    fadeController.forward();
  }

  reverse() {
    scaleController.reverse();
    fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: StateProvider().isAnimating,
        stream: stateBloc.animationStatus,
        builder: (context, snapshot) {
          snapshot.data ? forward() : reverse();

          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ProfileDetails(),
            ),
          );
        });
  }
}

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  var currentprofile = detailList.detail[1];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: Image.asset(
                        currentprofile.profilepic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        currentprofile.editorName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      currentprofile.editortag,
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      title: Transform.translate(
                        offset: Offset(-20, 0),
                        child: Text(
                          currentprofile.location,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'assets/instagram.png',
                          fit: BoxFit.cover,
                          height: 20,
                        ),
                        title: Transform.translate(
                          offset: Offset(-20, 0),
                          child: Text(
                            currentprofile.insta,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
