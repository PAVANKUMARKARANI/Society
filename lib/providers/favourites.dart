import 'package:flutter/material.dart';

class FavoritesExpansionTile extends StatefulWidget {
  final VoidCallback onEdit;
  final List<String> categories;

  const FavoritesExpansionTile({
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
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
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
                const SizedBox(height: 8),
                ...widget.categories.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
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
