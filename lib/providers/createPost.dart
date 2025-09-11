import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreatePostSheet extends StatefulWidget {
  CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

enum PostType { text, media, poll }

class _CreatePostSheetState extends State<CreatePostSheet> {
  PostType _selectedType = PostType.text;

  final List<Map<String, String>> profiles = [
    {'name': 'Your Profile', 'imgUrl': 'https://picsum.photos/200'},
    {'name': 'Amazon KDP Success', 'imgUrl': 'https://i.pravatar.cc/200?img=2'},
  ];

  String selectedProfile = 'Your Profile';

  final TextEditingController _contentController = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  TextStyle get _currentTextStyle {
    return TextStyle(
      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _toggleUnderline() {
    setState(() {
      _isUnderline = !_isUnderline;
    });
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      List<PlatformFile> files = result.files;
      print("Picked files: ${files.map((f) => f.name).join(", ")}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              children: [
                Text(
                  "Create New Post On ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedProfile,
                      items: profiles.map((profile) {
                        return DropdownMenuItem<String>(
                          value: profile['name'],
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  profile['imgUrl']!,
                                ),
                                radius: 16,
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  profile['name']!,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "Post Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PostTypeButton(
                  icon: Icons.description,
                  label: "Text",
                  selected: _selectedType == PostType.text,
                  onTap: () => setState(() => _selectedType = PostType.text),
                ),
                SizedBox(width: 12),
                _PostTypeButton(
                  icon: Icons.image,
                  label: "Media",
                  selected: _selectedType == PostType.media,
                  onTap: () => setState(() => _selectedType = PostType.media),
                ),
                SizedBox(width: 12),
                _PostTypeButton(
                  icon: Icons.poll,
                  label: "Poll",
                  selected: _selectedType == PostType.poll,
                  onTap: () => setState(() => _selectedType = PostType.poll),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "What is the post about ?",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            if (_selectedType == PostType.text) ...[
              Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  "Content",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.format_bold,
                      color: _isBold ? Colors.blue : Colors.black,
                    ),
                    onPressed: _toggleBold,
                    tooltip: 'Bold',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_italic,
                      color: _isItalic ? Colors.blue : Colors.black,
                    ),
                    onPressed: _toggleItalic,
                    tooltip: 'Italic',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_underline,
                      color: _isUnderline ? Colors.blue : Colors.black,
                    ),
                    onPressed: _toggleUnderline,
                    tooltip: 'Underline',
                  ),
                  IconButton(icon: Icon(Icons.link), onPressed: () {}),
                  IconButton(icon: Icon(Icons.cancel), onPressed: () {}),
                  IconButton(icon: Icon(Icons.smart_display), onPressed: () {}),
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: RichText(
                      text: TextSpan(
                        text: _contentController.text,
                        style: _currentTextStyle.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _contentController,
                    maxLines: 8,
                    minLines: 5,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintText: "Content",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (str) {
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  "Attachments (optional)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 200));
                  await _pickFiles();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("Add Media", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ] else if (_selectedType == PostType.media) ...[
              Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  "Media",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 200));
                  await _pickFiles();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("Add Media", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ] else if (_selectedType == PostType.poll) ...[
              Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  "Poll Options",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _PollCreationWidget(),
              ),
            ],
            SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.send),
                label: Text("Publish Post"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _PostTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PostTypeButton({
    required this.icon,
    required this.label,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected ? Color(0xFFEFF5FF) : Colors.white;
    final borderColor = selected ? Color(0xFF2196F3) : Colors.grey.shade300;
    final textColor = selected ? Color(0xFF2196F3) : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: 80),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: selected ? 2 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 18),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: textColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PollCreationWidget extends StatefulWidget {
  @override
  State<_PollCreationWidget> createState() => _PollCreationWidgetState();
}

class _PollCreationWidgetState extends State<_PollCreationWidget> {
  bool isQuiz = false;
  List<TextEditingController> options = [
    TextEditingController(),
    TextEditingController(),
  ];
  int? selectedQuizIndex;
  static int maxOptions = 5;

  @override
  void dispose() {
    for (var c in options) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isQuiz ? Icons.help_outline_rounded : Icons.bar_chart_rounded,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 6),
            Text(
              isQuiz ? "Create Quiz" : "Create Poll",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        SizedBox(height: 11),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => setState(() {
                isQuiz = false;
                selectedQuizIndex = null;
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: !isQuiz ? Colors.black : Colors.grey[100],
                foregroundColor: !isQuiz ? Colors.white : Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0,
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.bar_chart, size: 17),
                  SizedBox(width: 4),
                  Text("Poll", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => setState(() {
                isQuiz = true;
                selectedQuizIndex = null;
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: isQuiz ? Colors.black : Colors.grey[100],
                foregroundColor: isQuiz ? Colors.white : Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0,
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.help_outline, size: 17),
                  SizedBox(width: 4),
                  Text("Quiz", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
        if (isQuiz)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 2, bottom: 6),
            child: Text(
              "Select the correct answer by clicking the checkbox",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        for (int i = 0; i < options.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 7, left: 2),
                  width: 28,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${i + 1}'),
                ),
                Expanded(
                  child: TextField(
                    controller: options[i],
                    decoration: InputDecoration(
                      hintText: "Option ${i + 1}",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                if (isQuiz)
                  Checkbox(
                    value: selectedQuizIndex == i,
                    onChanged: (_) {
                      setState(() {
                        selectedQuizIndex = i;
                      });
                    },
                  ),
                if (options.length > 2)
                  IconButton(
                    icon: Icon(Icons.close_rounded, size: 22),
                    onPressed: () {
                      setState(() {
                        options.removeAt(i);
                        if (selectedQuizIndex == i) {
                          selectedQuizIndex = null;
                        } else if (selectedQuizIndex != null &&
                            selectedQuizIndex! > i) {
                          selectedQuizIndex = selectedQuizIndex! - 1;
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        if (options.length < maxOptions)
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: TextButton.icon(
              onPressed: () =>
                  setState(() => options.add(TextEditingController())),
              icon: Icon(Icons.add, size: 18),
              label: Text("Add Option  ${options.length}/$maxOptions"),
            ),
          ),
      ],
    );
  }
}
