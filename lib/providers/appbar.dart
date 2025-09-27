import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(
      "Society",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
      Padding(
        padding: EdgeInsets.only(right: 12),
        child: Hero(
          tag: "profile-avatar",
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://picsum.photos/200"),
            radius: 18,
          ),
        ),
      ),
    ],
  );
}
