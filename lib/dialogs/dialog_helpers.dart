import 'package:flutter/material.dart';

void showEditInterestsDialog(BuildContext context) {
  final _controller = TextEditingController();
  int maxChars = 150;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Edit Interests",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  maxLength: maxChars,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter Interests",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    counterText: "",
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 4),
                Text(
                  "${_controller.text.length}/$maxChars characters",
                  style: TextStyle(color: Colors.green[600]),
                ),
              ],
            );
          },
        ),
        actionsPadding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      );
    },
  );
}

void showEditTextDialog(BuildContext context, String title, String hintText) {
  final _controller = TextEditingController();
  int maxChars = 150;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                minLines: 3,
                maxLines: 5,
                maxLength: maxChars,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  counterText: '',
                ),
                onChanged: (_) => setState(() {}),
              ),
              SizedBox(height: 4),
              Text(
                '${_controller.text.length}/$maxChars characters',
                style: TextStyle(color: Colors.green[600]),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      );
    },
  );
}

void showAddHometownDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Add Hometown",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Search your home town",
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
      );
    },
  );
}
