import 'package:flutter/material.dart';

void showConnectionsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: SizedBox(
          width: double.infinity,
          height:
              MediaQuery.of(context).size.height *
              0.85, // large, almost fullscreen
          child: ConnectionsContent(),
        ),
      );
    },
  );
}

class ConnectionsContent extends StatefulWidget {
  @override
  State<ConnectionsContent> createState() => _ConnectionsContentState();
}

class _ConnectionsContentState extends State<ConnectionsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Connections',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "Followers (0)",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Following (0)",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          indicator: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
          ),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 32),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Followers',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text("No followers yet")),
              Center(child: Text("Not following anyone yet")),
            ],
          ),
        ),
      ],
    );
  }
}
