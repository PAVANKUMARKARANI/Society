import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditMusicDialog extends StatefulWidget {
  final VoidCallback onSave;

  const EditMusicDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<EditMusicDialog> createState() => _EditMusicDialogState();
}

class _EditMusicDialogState extends State<EditMusicDialog> {
  String spotifyType = 'Spotify Playlist';
  final spotifyCtrl = TextEditingController();
  final ytCtrl = TextEditingController();

  @override
  void dispose() {
    spotifyCtrl.dispose();
    ytCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Music",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 28),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.spotify,
                            color: Color(0xFF1ED760),
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Spotify",
                            style: TextStyle(
                              color: Color(0xFF1ED760),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Text(
                        "Choose Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: spotifyType,
                        items: ['Spotify Playlist', 'Spotify Album']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => spotifyType = val!,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Paste Spotify Playlist Link",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: spotifyCtrl,
                        decoration: InputDecoration(
                          hintText: "Enter any public Spotify playlist link",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          /* Launch Spotify */
                        },
                        child: Text(
                          "Open Spotify",
                          style: TextStyle(
                            color: Color(0xFF3678F8),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Color(0xFFEA4335),
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "YouTube Music",
                            style: TextStyle(
                              color: Color(0xFFB31313),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Text(
                        "Playlist Url",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: ytCtrl,
                        decoration: InputDecoration(
                          hintText: "Enter youtube playlist url",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Open YouTube Music",
                          style: TextStyle(
                            color: Color(0xFF3678F8),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size.fromHeight(42),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: Text('save', style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),

                Row(
                  children: [
                    SizedBox(
                      width: 85,
                      child: Text(
                        "Movies",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                      ),
                      child: Text("Add Movie"),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        "TV/Web Series",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                      ),
                      child: Text("Add Show"),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    SizedBox(
                      width: 65,
                      child: Text(
                        "Books",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                      ),
                      child: Text("Add Book"),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size.fromHeight(42),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save', style: TextStyle(fontSize: 17)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
