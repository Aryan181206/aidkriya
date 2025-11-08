import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    transactions = [
      {
        'icon': Icons.square_foot,
        'title': 'Walk for Sarah J.',
        'subtitle': 'Oct 26, 2:30 PM',
        'amount': '+\$15.00',
        'status': 'Completed',
        'positive': true,
      },
      {
        'icon': Icons.calendar_month,
        'title': 'Weekly Payout',
        'subtitle': 'Oct 24, 8:00 AM',
        'amount': '+\$85.50',
        'status': 'Completed',
        'positive': true,
      },
      {
        'icon': Icons.account_balance,
        'title': 'Withdrawal to Bank',
        'subtitle': 'Oct 20, 10:15 AM',
        'amount': '-\$50.00',
        'status': 'Pending',
        'positive': false,
      },
      {
        'icon': Icons.error,
        'title': 'Walk for Mike B.',
        'subtitle': 'Oct 19, 5:00 PM',
        'amount': '+\$20.00',
        'status': 'Failed',
        'positive': true,
        'statusColor': Colors.red,
      },
    ];
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF23220f) : Colors.white;
    final Color textColor = isDark ? const Color(0xFFF8F8F5) : const Color(0xFF212121);
    final Color subtleColor = isDark ? const Color(0xFF8c8b5f) : const Color(0xFFAEAEB2);
    const Color primaryColor = Color(0xFFF9F506);
    const Color successColor = Color(0xFF34C759);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios_new, color: textColor),
        title: Text("My Wallet",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.help_outline, color: textColor),
              onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadTransactions,
        color: primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wallet Balance Card
                _isLoading
                    ? _shimmerCard()
                    : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black : Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Available Balance",
                          style: TextStyle(
                              color: subtleColor, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text("\$124.50",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Withdraw Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Withdraw Funds",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 24),

                Text("Recent Activity",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                const SizedBox(height: 12),

                if (_isLoading)
                  ...List.generate(4, (_) => _shimmerItem())
                else
                  ...transactions.map((tx) => _transactionItem(
                    icon: tx['icon'],
                    title: tx['title'],
                    subtitle: tx['subtitle'],
                    amount: tx['amount'],
                    status: tx['status'],
                    isPositive: tx['positive'],
                    textColor: textColor,
                    subtleColor: subtleColor,
                    successColor: successColor,
                    statusColor: tx['statusColor'],
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _transactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String status,
    required bool isPositive,
    required Color textColor,
    required Color subtleColor,
    required Color successColor,
    Color? statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: textColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Text(subtitle,
                      style: TextStyle(color: subtleColor, fontSize: 13)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: TextStyle(
                      color: isPositive ? successColor : textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
              Text(status,
                  style: TextStyle(
                      color: statusColor ?? subtleColor, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  // --- Shimmer placeholders ---
  Widget _shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _shimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
