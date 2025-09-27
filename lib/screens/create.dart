import 'package:flutter/material.dart';
import 'package:society/providers/appbar.dart';
import 'package:society/providers/drawer.dart';

class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Create a New Community',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Choose the type of community you want to create.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Free Community Card
            _CreateOptionCard(
              title: 'Free Community',
              description:
                  'For hobbies, interests, businesses, and more. Create a standard community to connect and share.',
              buttonLabel: 'Create Free Community',
              onPressed: () {},
              buttonColor: Colors.black,
            ),
            SizedBox(height: 20),
            // Paid Group Card
            _CreateOptionCard(
              title: 'Paid Group',
              description:
                  'Create a private community and charge a one-time fee or a recurring subscription for access.',
              buttonLabel: 'Create Paid Group',
              onPressed: null, // disables button when limit reached
              buttonColor: Colors.grey,
              warning: 'Paid group limit reached',
            ),
            SizedBox(height: 20),
            // Membership Card
            _CreateOptionCard(
              title: 'Membership',
              description:
                  'Offer recurring subscriptions with new daily, weekly, or monthly content for your subscribers.',
              buttonLabel: 'Create Membership',
              onPressed: null, // disables button when limit reached
              buttonColor: Colors.grey,
              warning: 'Paid group limit reached',
            ),
            SizedBox(height: 32),
            // Limits info
            Card(
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Free groups:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '3 remaining',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 35),
                    Column(
                      children: [
                        Text(
                          'Paid groups / Memberships:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '0 remaining',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final String? warning;

  const _CreateOptionCard({
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    required this.buttonColor,
    this.warning,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 9),
            Text(
              description,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: Text(
                  buttonLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (warning != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  warning!,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
