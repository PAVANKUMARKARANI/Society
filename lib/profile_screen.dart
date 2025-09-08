import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> expandedTiles = {};
  final String? societyLink = "https://society.so/vikas27459";
  final List<String> topFriends = [];
  final List<String> workDetails = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Widget _topFriendsWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Friends / Connections",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                SizedBox(height: 8),
                if (topFriends.isEmpty)
                  Text(
                    "No top connections selected.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: topFriends
                        .map(
                          (friend) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(friend, style: TextStyle(fontSize: 16)),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined),
            iconSize: 20,
            tooltip: "Edit Top Friends",
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => EditTopConnectionsDialog(
                  connections: topFriends,
                  onUpdate: (updated) {
                    setState(() {
                      topFriends.clear();
                      topFriends.addAll(updated);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEditMoodDialog(BuildContext context) {
    String? selectedMood;
    List<String> moods = ['Happy', 'Sad', 'Excited', 'Thoughtful'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Edit Mood',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              value: selectedMood,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: 'Select Mood',
                filled: true,
                fillColor: Colors.white,
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
              ),
              items: moods
                  .map(
                    (mood) => DropdownMenuItem(value: mood, child: Text(mood)),
                  )
                  .toList(),
              onChanged: (value) => selectedMood = value,
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

  void _showEditTextDialog(
    BuildContext context,
    String title,
    String hintText,
  ) {
    final _controller = TextEditingController();
    int maxChars = 150;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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

  void _showEditRelationshipStatusDialog(BuildContext context) {
    String? selectedStatus;
    List<String> statuses = ['Single', 'Married', 'In a Relationship', 'Other'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Edit Relationship Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<String>(
              value: selectedStatus,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: 'Select Relationship Status',
                filled: true,
                fillColor: Colors.white,
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
              ),
              items: statuses
                  .map(
                    (status) =>
                        DropdownMenuItem(value: status, child: Text(status)),
                  )
                  .toList(),
              onChanged: (value) => selectedStatus = value,
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

  void _showEditCompanyDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String companyName = '';
    String companyURL = '';
    String position = '';

    InputDecoration borderedInput(String hint) => InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Company',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Company Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: borderedInput('Company Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter company name'
                        : null,
                    onChanged: (val) => companyName = val,
                  ),
                  SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Company URL',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: borderedInput('Company URL'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter company URL'
                        : null,
                    onChanged: (val) => companyURL = val,
                  ),
                  SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Position (Optional)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: borderedInput(
                      'Position (e.g. Software Engineer)',
                    ),
                    onChanged: (val) => position = val,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(70, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditInterestsDialog(BuildContext context) {
    final _controller = TextEditingController();
    int maxChars = 150;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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

  void _showAddHometownDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Add Hometown",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Search your home town",
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
            ),
          ),
        );
      },
    );
  }

  void _showEditEducationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Padding(
            padding: EdgeInsets.fromLTRB(28, 18, 28, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.graduationCap, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Edit Education",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),

                Text(
                  "College",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                SizedBox(
                  width: 120,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 18),
                    label: Text("Add"),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22),

                Text(
                  "School",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                SizedBox(
                  width: 120,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 18),
                    label: Text("Add"),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                        padding: EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
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
            padding: EdgeInsets.only(right: 12.0),
            child: Hero(
              tag: "profile-avatar",
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/200"),
                radius: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(20),
                      //bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/600"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -45,
                  left: 20,
                  child: Hero(
                    tag: "profile-avatar",
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        radius: 54,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/201",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 600),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      "Vikas2",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("@vikas27459", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _AnimatedStatItem(
                          label: "Followers",
                          value: "0",
                          delay: 200,
                        ),
                        _AnimatedStatItem(
                          label: "Following",
                          value: "0",
                          delay: 400,
                        ),
                        _AnimatedStatItem(
                          label: "Posts",
                          value: "0",
                          delay: 600,
                        ),
                      ],
                    ),

                    SizedBox(height: 12),
                    Text(
                      "Joined 16 Aug 25",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 12),

                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: SizedBox(
                        width: 150,
                        child: OutlinedButton.icon(
                          key: UniqueKey(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.edit, size: 16),
                          label: Text("Edit Profile"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(16),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.2),
                    //       blurRadius: 6,
                    //       offset: const Offset(0, 3),
                    //     ),
                    //   ],
                    // ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.deepPurple,
                      indicatorWeight: 3,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      tabs: [
                        Tab(text: "Posts"),
                        Tab(text: "Groups"),
                        Tab(text: "Media"),
                        Tab(text: "About me"),
                        Tab(text: "Showcase"),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _postsTabContent(context),
                        _animatedTab("Groups"),
                        _animatedTab("Media"),
                        _animatedTab("About me"),
                        _animatedTab("Showcase"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            _buildExpansionTile(
              title: "My Society Link",
              child: societyLink != null
                  ? GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: societyLink!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              societyLink!,
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 13, 145),
                              ),
                            ),
                          ),
                          Icon(Icons.copy, size: 18, color: Colors.grey),
                        ],
                      ),
                    )
                  : Text("No data available for My Society Link"),
            ),
            _buildExpansionTile(
              title: "Top Friends",
              child: _topFriendsWidget(),
            ),
            _buildExpansionTile(
              title: "Work",
              child: workDetails.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: workDetails.map((work) => Text(work)).toList(),
                    )
                  : Text("No work details available."),
              onEdit: () {
                _showEditCompanyDialog(context);
              },
            ),
            _buildExpansionTile(
              title: "Mood",
              child: Text("No data available for Mood"),
              onEdit: () {
                _showEditMoodDialog(context);
              },
            ),
            _buildExpansionTile(
              title: "Who I would like to meet",
              child: Text("No data available for Who I would like to meet"),
              onEdit: () {
                _showEditTextDialog(
                  context,
                  "Edit Who I'd Like to Meet",
                  "Enter Who I'd Like to Meet",
                );
              },
            ),
            _buildExpansionTile(
              title: "Here for",
              child: Text("No data available for Here for"),
              onEdit: () {
                _showEditTextDialog(context, "Edit Here For", "Enter Here For");
              },
            ),
            _buildExpansionTile(
              title: "Relationship Status",
              child: Text("No data available for Relationship Status"),
              onEdit: () {
                _showEditRelationshipStatusDialog(context);
              },
            ),
            _buildExpansionTile(
              title: "Interests",
              child: Text("No data available for Interests"),
              onEdit: () {
                _showEditInterestsDialog(context);
              },
            ),
            _buildExpansionTile(
              title: "Hometown",
              child: Text("No data available for Hometown"),
              onEdit: () {
                _showAddHometownDialog(context);
              },
            ),
            FavoritesExpansionTile(
              onEdit: () {
                _showEditMusicDialog(context);
              },
              categories: ['Music', 'Movies', 'Tv Shows', 'Books'],
            ),
            EducationExpansionTile(
              onEdit: () {
                _showEditEducationDialog(context);
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _postsTabContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [_writeSomethingCard(context), _postsEmptyState()],
    );
  }

  Widget _writeSomethingCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => _CreatePostSheet(),
          );
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write something…",
                  border: InputBorder.none,
                ),
                maxLines: null,
                enabled: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _postsEmptyState() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 48, color: Colors.black38),
              SizedBox(height: 16),
              Text(
                "No posts yet? Don’t worry, you can be the trendsetter!!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditMusicDialog(BuildContext context) {
    String? spotifyType = 'Spotify Playlist';
    final spotifyCtrl = TextEditingController();
    final ytCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 36),
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
                            onChanged: (val) => spotifyType = val,
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
                              hintText:
                                  "Enter any public Spotify playlist link",
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
                    // YouTube Music Section
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
      },
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required Widget child,
    VoidCallback? onEdit,
  }) {
    final isExpanded = expandedTiles.contains(title);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Expanded(
              child: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
            ),

            if (isExpanded && onEdit != null)
              IconButton(
                icon: Icon(Icons.edit, size: 20),
                onPressed: onEdit,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
          ],
        ),
        children: [Padding(padding: EdgeInsets.all(16.0), child: child)],
        onExpansionChanged: (expanded) {
          setState(() {
            if (expanded) {
              expandedTiles.add(title);
            } else {
              expandedTiles.remove(title);
            }
          });
        },
      ),
    );
  }

  static Widget _animatedTab(String text) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: Text(
          text,
          key: ValueKey(text),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}

class _CreatePostSheet extends StatefulWidget {
  _CreatePostSheet({super.key});

  @override
  State<_CreatePostSheet> createState() => _CreatePostSheetState();
}

enum PostType { text, media, poll }

class _CreatePostSheetState extends State<_CreatePostSheet> {
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

  Widget _buildExpansionTile(String title, Widget child) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        children: [Padding(padding: EdgeInsets.all(16.0), child: child)],
      ),
    );
  }

  static Widget _animatedTab(String text) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: Text(
          text,
          key: ValueKey(text),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
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

class _AnimatedStatItem extends StatelessWidget {
  final String label;
  final String value;
  final int delay;
  const _AnimatedStatItem({
    required this.label,
    required this.value,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: delay + 700),
      curve: Curves.easeOutBack,
      tween: Tween(begin: 0, end: 1),
      builder: (context, scale, _) {
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: scale.clamp(0.0, 1.0),
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FavoritesExpansionTile extends StatefulWidget {
  final VoidCallback onEdit;
  final List<String> categories;

  FavoritesExpansionTile({
    Key? key,
    required this.onEdit,
    required this.categories,
  }) : super(key: key);

  @override
  State<FavoritesExpansionTile> createState() => _FavoritesExpansionTileState();
}

class _FavoritesExpansionTileState extends State<FavoritesExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.w600)),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    if (isExpanded)
                      IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        onPressed: widget.onEdit,
                      ),
                  ],
                ),
                SizedBox(height: 8),
                ...widget.categories.map(
                  (cat) => Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 2,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EducationExpansionTile extends StatefulWidget {
  final VoidCallback onEdit;

  EducationExpansionTile({Key? key, required this.onEdit}) : super(key: key);

  @override
  State<EducationExpansionTile> createState() => _EducationExpansionTileState();
}

class _EducationExpansionTileState extends State<EducationExpansionTile> {
  bool isExpanded = false;

  final List<String> educationItems = ['College', 'School'];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Education', style: TextStyle(fontWeight: FontWeight.w600)),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        trailing: isExpanded
            ? IconButton(
                icon: Icon(Icons.edit_outlined, size: 20),
                onPressed: widget.onEdit,
              )
            : null,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: educationItems
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.08),
                              blurRadius: 2,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class EditTopConnectionsDialog extends StatefulWidget {
  final List<String> connections;
  final ValueChanged<List<String>> onUpdate;
  EditTopConnectionsDialog({
    required this.connections,
    required this.onUpdate,
    super.key,
  });

  @override
  State<EditTopConnectionsDialog> createState() =>
      _EditTopConnectionsDialogState();
}

class _EditTopConnectionsDialogState extends State<EditTopConnectionsDialog> {
  late List<String?> slots;

  @override
  void initState() {
    super.initState();
    // Copy the initial connections into 8 slots
    slots = List<String?>.generate(
      8,
      (i) => i < widget.connections.length ? widget.connections[i] : null,
    );
  }

  void pickConnection(int index) async {
    // Provide your real friends list here
    List<String> allFriends = [
      'Alice',
      'Bob',
      'Charlie',
      'David',
      'Emma',
    ]; // sample data
    String? picked = await showDialog<String>(
      context: context,
      builder: (_) => FriendSearchDialog(allFriends: allFriends),
    );
    if (picked != null && picked.trim().isNotEmpty) {
      setState(() {
        slots[index] = picked.trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Edit Top Connections',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    8,
                    (i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            'Connection ${i + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 18),
                          if (slots[i] == null)
                            ElevatedButton.icon(
                              onPressed: () => pickConnection(i),
                              icon: Icon(Icons.add, size: 18),
                              label: Text('Add'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey.shade200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        slots[i]!,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          slots[i] = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  widget.onUpdate(slots.whereType<String>().toList());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Update', style: TextStyle(fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendSearchDialog extends StatefulWidget {
  final List<String> allFriends;
  FriendSearchDialog({required this.allFriends, super.key});
  @override
  State<FriendSearchDialog> createState() => _FriendSearchDialogState();
}

class _FriendSearchDialogState extends State<FriendSearchDialog> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = query.isEmpty
        ? []
        : widget.allFriends
              .where((f) => f.toLowerCase().contains(query.toLowerCase()))
              .toList();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Choose a friend',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            TextField(
              autofocus: true,
              onChanged: (v) => setState(() {
                query = v;
              }),
              decoration: InputDecoration(
                hintText: "Search for a friend",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (query.isEmpty)
              Text(
                'Enter a username to search.',
                style: TextStyle(color: Colors.grey),
              ),
            if (query.isNotEmpty && filtered.isEmpty)
              Text('No friends found.', style: TextStyle(color: Colors.grey)),
            if (filtered.isNotEmpty)
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: filtered
                      .map(
                        (f) => ListTile(
                          title: Text(f),
                          onTap: () => Navigator.of(context).pop(f),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
