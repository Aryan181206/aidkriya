import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 100),
            const SizedBox(height: 20),
            const Text("Payment Successful!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFFC00),
                foregroundColor: Colors.black,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
