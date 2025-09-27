import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    "Navigation",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Search"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.explore_outlined),
              title: Text("Connections"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.groups_outlined),
              title: Text("Groups"),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Groups",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Create"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Explore"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.groups_outlined),
              title: Text("My Groups"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("My Memberships"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text("Invitations"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Support"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Feedback"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
