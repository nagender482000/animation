import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../bloc/state_bloc.dart';
import '../bloc/state_provider.dart';
import '/model/data.dart';

var currentprofile = detailList.detail[1];

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
  static const routeName = '/profie';
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(currentprofile.bgpic),
                    fit: BoxFit.cover)),
          ),
          CarDetailsAnimation(),
          CustomBottomSheet(),
        ],
      ),
    );
  }
}

class CarDetailsAnimation extends StatefulWidget {
  @override
  _CarDetailsAnimationState createState() => _CarDetailsAnimationState();
}

class _CarDetailsAnimationState extends State<CarDetailsAnimation>
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

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 500;
  double minSheetTop = 120;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

  reverseAnimation() {
    Navigator.pop(context);
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          reverseAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          if (dragEndDetails.primaryVelocity > 0.0) {
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, right: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Color(0xfff1f1f1)),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 25),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffd9dbdb)),
          ),
          offerDetails(),
          SizedBox(height: 220),
        ],
      ),
    );
  }
}

offerDetails() {
  return Padding(
      padding: EdgeInsets.only(top: 5, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Photos",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Text(
                "Likes",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(
                "Collections",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                RelatedpicsSection(0),
                SizedBox(
                  height: 20,
                ),
                RelatedpicsSection(1),
              ],
            ),
          ),
        ],
      ));
}

class RelatedpicsSection extends StatelessWidget {
  final int i;
  RelatedpicsSection(this.i);
  @override
  Widget build(BuildContext context) {
    var sheetItemHeight = MediaQuery.of(context).size.height * .25;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(
            top: 15,
            right: 20,
          ),
          height: sheetItemHeight,
          width: sheetItemHeight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(currentprofile.relatedphotos[i]),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
