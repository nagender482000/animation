import 'package:flutter/material.dart';

DetailList detailList = DetailList(detail: [
  Details(
    profilepic: 'assets/profile3.png',
    editorName: "Caleb George",
    editortag: "@xcaleb",
    location: "Broadway, New York",
    insta: "instagram.com/caleb_george",
    bgpic: "assets/3.jpg",
  ),
  Details(
    profilepic: 'assets/profile4.png',
    editorName: "Teemu Paananen",
    editortag: "@xteemu",
    location: "Stockholm, Sweden",
    insta: "instagram.com/teemography",
    bgpic: "assets/2.jpg",
    relatedphotos: [
      'assets/3.jpg',
      'assets/1.jpg',
    ],
  ),
  Details(
    profilepic: 'assets/profile2.png',
    editorName: "Leonard Cotte",
    editortag: "@xleonard",
    location: "Los Angeles, California",
    insta: "instagram.com/leonard.cotte",
    bgpic: "assets/1.jpg",
    relatedphotos: [
      'assets/2.jpg',
      'assets/3.jpg',
    ],
  ),
  Details(
    profilepic: 'assets/profile1.png',
    editorName: "Nagender Singh",
    editortag: "@xnss",
    location: "Jodhpur, Rajasthan",
    insta: "instagram.com/nss",
    bgpic: "assets/2.jpg",
    relatedphotos: [
      'assets/3.jpg',
      'assets/1.jpg',
    ],
  ),
]);

class DetailList {
  List<Details> detail;

  DetailList({
    @required this.detail,
  });
}

class Details {
  String profilepic;
  String editorName;
  String editortag;
  String location;
  String insta;
  String bgpic;
  List<String> relatedphotos;

  Details({
    this.profilepic,
    this.editorName,
    this.editortag,
    this.location,
    this.insta,
    this.bgpic,
    this.relatedphotos,
  });
}
