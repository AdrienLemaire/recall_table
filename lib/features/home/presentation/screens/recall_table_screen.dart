import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recall_table/core/theme/constants.dart';

class RecallTableScreen extends StatefulWidget {
  const RecallTableScreen({super.key});

  @override
  RecallTableScreenState createState() => RecallTableScreenState();
}

class RecallTableScreenState extends State<RecallTableScreen> {
  bool isLoading = false;

  void _navigateToLearn() async {
    setState(() {
      isLoading = true; // Start loading
    });

    // Simulate a network request or heavy computation before navigating
    // await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        isLoading = false; // Stop loading
      });

      // Navigate to the Learn screen
      context.go('/learn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recall Table'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: ThemeConstants.maxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : _navigateToLearn,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Learn'),
              ),
              const SizedBox(height: 16),
              const ElevatedButton(
                onPressed: null, // Disabled
                child: Text('Train'),
              ),
              const SizedBox(height: 16),
              const ElevatedButton(
                onPressed: null, // Disabled
                child: Text('Battle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
