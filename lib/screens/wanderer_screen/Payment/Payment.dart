import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  final double duration;
  final double rate;
  final double distance;
  final String upiId;

  const PaymentScreen({
    super.key,
    required this.duration,
    required this.rate,
    required this.distance,
    required this.upiId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late double totalAmount;
  bool _isPaying = false;

  @override
  void initState() {
    super.initState();
    totalAmount = (widget.rate * widget.distance);
  }

  Future<void> _startTransaction() async {
    setState(() => _isPaying = true);

    final upiUrl =
        "upi://pay?pa=${widget.upiId}&pn=Walker%20Services&am=${totalAmount.toStringAsFixed(2)}&cu=INR&tn=Ride%20Payment";

    final Uri uri = Uri.parse(upiUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        setState(() => _isPaying = false);
        _showSuccessDialog();
      } else {
        setState(() => _isPaying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No UPI app found on your device.")),
        );
      }
    } catch (e) {
      setState(() => _isPaying = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment failed: $e")));
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Initiated"),
        content: const Text(
          "Your payment request has been sent to your UPI app.\nPlease confirm the payment there.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentSuccessScreen(),
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
        backgroundColor: Colors.yellow.shade600,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRow("Duration", "${widget.duration} min"),
                    _buildRow("Distance", "${widget.distance} km"),
                    _buildRow("Rate", "₹${widget.rate.toStringAsFixed(2)} / km"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "₹${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isPaying ? null : _startTransaction,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: _isPaying
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                "Pay with UPI",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
              const TextStyle(fontSize: 15, color: Colors.grey, height: 1.2)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text("Payment Successful!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
