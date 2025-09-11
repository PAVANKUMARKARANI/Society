import 'package:flutter/material.dart';

class EditFieldDialog extends StatefulWidget {
  final String title;
  final String? initialValue;
  final String hintText;
  final List<String>? dropdownOptions;
  final ValueChanged<String> onSave;

  const EditFieldDialog({
    Key? key,
    required this.title,
    required this.onSave,
    this.initialValue,
    this.hintText = '',
    this.dropdownOptions,
  }) : super(key: key);

  @override
  State<EditFieldDialog> createState() => _EditFieldDialogState();
}

class _EditFieldDialogState extends State<EditFieldDialog> {
  late String? selectedValue;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showAddHometownDialog(BuildContext context) {
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

  bool get isDropdown =>
      widget.dropdownOptions != null && widget.dropdownOptions!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: isDropdown
          ? DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              items: widget.dropdownOptions!
                  .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedValue = val;
                });
              },
            )
          : TextField(
              controller: _controller,
              maxLength: 150,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                counterText: '',
              ),
              onChanged: (_) => setState(() {}),
            ),
      actionsPadding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0,
            ),
            onPressed: () {
              final result = isDropdown
                  ? (selectedValue ?? '')
                  : _controller.text.trim();
              if (result.isNotEmpty) {
                widget.onSave(result);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
