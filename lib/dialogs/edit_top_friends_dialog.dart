import 'package:flutter/material.dart';

class EditTopFriendsDialog extends StatefulWidget {
  final List<String> initialFriends;
  final ValueChanged<List<String>> onUpdate;

  const EditTopFriendsDialog({
    Key? key,
    required this.initialFriends,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<EditTopFriendsDialog> createState() => _EditTopFriendsDialogState();
}

class _EditTopFriendsDialogState extends State<EditTopFriendsDialog> {
  late List<String?> slots;

  @override
  void initState() {
    super.initState();
    slots = List<String?>.generate(
      8,
      (i) => i < widget.initialFriends.length ? widget.initialFriends[i] : null,
    );
  }

  Future<void> pickFriend(int index) async {
    List<String> allFriends = ['Alice', 'Bob', 'Charlie', 'David', 'Emma'];
    String? picked = await showDialog(
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Edit Top Connections',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(8, (i) {
                    final friendName = slots[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            'Connection ${i + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 18),
                          if (friendName == null)
                            ElevatedButton.icon(
                              onPressed: () => pickFriend(i),
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey.shade200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
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
                                        friendName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
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
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  widget.onUpdate(slots.whereType<String>().toList());
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Update', style: TextStyle(fontSize: 17)),
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
  const FriendSearchDialog({Key? key, required this.allFriends})
    : super(key: key);

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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Choose a friend',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search for a friend',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (query.isEmpty)
              const Text(
                'Enter a username to search.',
                style: TextStyle(color: Colors.grey),
              ),
            if (query.isNotEmpty && filtered.isEmpty)
              const Text(
                'No friends found.',
                style: TextStyle(color: Colors.grey),
              ),
            if (filtered.isNotEmpty)
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final friend = filtered[index];
                    return ListTile(
                      title: Text(friend),
                      onTap: () => Navigator.of(context).pop(friend),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
