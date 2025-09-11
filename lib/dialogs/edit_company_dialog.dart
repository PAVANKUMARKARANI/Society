import 'package:flutter/material.dart';

class EditCompanyDialog extends StatefulWidget {
  final ValueChanged<Map<String, String>> onSave;
  final Map<String, String>? initialData;

  const EditCompanyDialog({Key? key, required this.onSave, this.initialData})
    : super(key: key);

  @override
  State<EditCompanyDialog> createState() => _EditCompanyDialogState();
}

class _EditCompanyDialogState extends State<EditCompanyDialog> {
  final _formKey = GlobalKey<FormState>();

  late String companyName;
  late String companyURL;
  late String position;

  @override
  void initState() {
    super.initState();
    companyName = widget.initialData?['companyName'] ?? '';
    companyURL = widget.initialData?['companyURL'] ?? '';
    position = widget.initialData?['position'] ?? '';
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Edit Company',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Company Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                initialValue: companyName,
                decoration: _inputDecoration('Company Name'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter company name' : null,
                onChanged: (val) => companyName = val,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Company URL',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                initialValue: companyURL,
                decoration: _inputDecoration('Company URL'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter company URL' : null,
                onChanged: (val) => companyURL = val,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Position (Optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                initialValue: position,
                decoration: _inputDecoration(
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
            minimumSize: const Size(70, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSave({
                'companyName': companyName,
                'companyURL': companyURL,
                'position': position,
              });
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
