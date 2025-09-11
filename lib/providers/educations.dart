import 'package:flutter/material.dart';

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
