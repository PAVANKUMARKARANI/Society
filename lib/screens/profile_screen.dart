import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:society/providers/educations.dart';
import 'package:society/providers/Animation.dart';
import 'package:society/providers/createPost.dart';
import 'package:society/providers/favourites.dart';
import '../providers/profile_provider.dart';
import '../dialogs/edit_field_dialog.dart';
import '../dialogs/edit_company_dialog.dart';
import '../dialogs/edit_music_dialog.dart';
import '../dialogs/edit_top_friends_dialog.dart';
import 'package:society/dialogs/dialog_helpers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> expandedTiles = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showMoodDialog() {
    final profile = ref.read(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    String? selectedMood = profile.mood;

    showDialog(
      context: context,
      builder: (_) => EditFieldDialog(
        title: 'Edit Mood',
        dropdownOptions: ['Happy', 'Sad', 'Excited', 'Thoughtful'],
        initialValue: selectedMood,
        onSave: (val) => notifier.updateMood(val),
      ),
    );
  }

  void _showRelationshipDialog() {
    final profile = ref.read(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    String? selectedStatus = profile.relationshipStatus;

    showDialog(
      context: context,
      builder: (_) => EditFieldDialog(
        title: 'Edit Relationship Status',
        dropdownOptions: ['Single', 'Married', 'In a Relationship', 'Other'],
        initialValue: selectedStatus,
        onSave: (val) => notifier.updateRelationshipStatus(val),
      ),
    );
  }

  void _showCompanyDialog() {
    final profile = ref.read(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
    Map<String, String> company = {};
    if (profile.workDetails.isNotEmpty) {
      company = {
        'companyName': profile.workDetails[0],
        'companyURL': profile.workDetails.length > 1
            ? profile.workDetails[1]
            : '',
        'position': profile.workDetails.length > 2
            ? profile.workDetails[2]
            : '',
      };
    }

    showDialog(
      context: context,
      builder: (_) => EditCompanyDialog(
        initialData: company,
        onSave: (val) {
          notifier.updateWorkDetails([
            val['companyName'] ?? '',
            val['companyURL'] ?? '',
            val['position'] ?? '',
          ]);
        },
      ),
    );
  }

  void _showTopFriendsDialog() {
    final profile = ref.read(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    showDialog(
      context: context,
      builder: (_) => EditTopFriendsDialog(
        initialFriends: profile.topFriends,
        onUpdate: (val) => notifier.updateTopFriends(val),
      ),
    );
  }

  void _showEditEducationDialog() {
    String college = '';
    String school = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Edit Education",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'College',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF7752FE),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) => setState(() => college = val),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'School',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF7752FE),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) => setState(() => school = val),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMusicDialog() {
    final notifier = ref.read(profileProvider.notifier);

    showDialog(
      context: context,
      builder: (_) => EditMusicDialog(
        onSave: () {
          notifier.updateWorkDetails([]);
        },
      ),
    );
  }

  Widget _buildTopFriendsWidget(List<String> topFriends) {
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
                          (f) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(f, style: TextStyle(fontSize: 16)),
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
            onPressed: _showTopFriendsDialog,
          ),
        ],
      ),
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
        children: [Padding(padding: EdgeInsets.all(16), child: child)],
        onExpansionChanged: (expanded) {
          setState(() {
            if (expanded)
              expandedTiles.add(title);
            else
              expandedTiles.remove(title);
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

  Widget _postsTabContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [_writeSomethingCard(context), _postsEmptyState()],
    );
  }

  Widget _writeSomethingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => CreatePostSheet(),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _postsEmptyState() {
    return Padding(
      padding: EdgeInsets.all(16),
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

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
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
            SizedBox(height: 58),
            AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 600),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      profile.topFriends.isNotEmpty
                          ? profile.topFriends[0]
                          : "Vikas2",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "@vikas2749",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedStatItem(
                          label: "Followers",
                          value: "0",
                          delay: 200,
                        ),
                        AnimatedStatItem(
                          label: "Following",
                          value: "0",
                          delay: 400,
                        ),
                        AnimatedStatItem(
                          label: "Posts",
                          value: "0",
                          delay: 600,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Joined 16 Aug 25",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: SizedBox(
                        width: 150,
                        child: OutlinedButton.icon(
                          key: ValueKey("edit_profile"),
                          onPressed: () {},
                          icon: Icon(Icons.edit, size: 16),
                          label: Text("Edit Profile"),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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
                      tabs: const [
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
              child: GestureDetector(
                onTap: () {
                  if (profile.societyLink != null) {
                    Clipboard.setData(
                      ClipboardData(text: profile.societyLink!),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        profile.societyLink ?? "No Society Link",
                        style: TextStyle(color: Color(0xff18138e)),
                      ),
                    ),
                    Icon(Icons.copy, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            _buildExpansionTile(
              title: "Top Friends",
              onEdit: _showTopFriendsDialog,
              child: _buildTopFriendsWidget(profile.topFriends),
            ),
            _buildExpansionTile(
              title: "Work",
              onEdit: _showCompanyDialog,
              child: profile.workDetails.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: profile.workDetails
                          .map((w) => Text(w))
                          .toList(),
                    )
                  : Text("No work details available"),
            ),
            _buildExpansionTile(
              title: "Mood",
              onEdit: _showMoodDialog,
              child: Text(profile.mood ?? "No mood set"),
            ),
            _buildExpansionTile(
              title: "Who I would like to meet",
              onEdit: () {
                showEditTextDialog(
                  context,
                  "Edit Who I'd Like to Meet",
                  "Enter Who I'd Like to Meet",
                );
              },
              child: Text("No data"),
            ),
            _buildExpansionTile(
              title: "Here for",
              onEdit: () {
                showEditTextDialog(context, "Edit Here For", "Enter Here For");
              },
              child: Text("No data"),
            ),
            _buildExpansionTile(
              title: "Relationship Status",
              onEdit: _showRelationshipDialog,
              child: Text(profile.relationshipStatus ?? "No status set"),
            ),
            _buildExpansionTile(
              title: "Interests",
              onEdit: () {
                showEditInterestsDialog(context);
              },
              child: Text("No data"),
            ),
            _buildExpansionTile(
              title: "Hometown",
              onEdit: () {
                showAddHometownDialog(context);
              },
              child: Text("No data"),
            ),
            FavoritesExpansionTile(
              categories: ['Music', 'Movies', 'TV Shows', 'Books'],
              onEdit: _showMusicDialog,
            ),
            EducationExpansionTile(
              onEdit: () {
                _showEditEducationDialog();
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
