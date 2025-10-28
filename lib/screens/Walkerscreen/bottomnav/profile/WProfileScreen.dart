import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WProfileScreen extends StatelessWidget {
  const WProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFF9F506);
    final Color bgLight = const Color(0xFFF8F8F5);
    final Color textDark = const Color(0xFF181811);

    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgLight,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold, color: textDark),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_horiz, color: Colors.black),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/pfsample1.png'),  ),
            const SizedBox(height: 12),
            Text(
              "Alex Doe",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "Loves long walks on the beach and exploring new city parks. Let's walk and talk!",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(
                  "4.8 ",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, color: textDark),
                ),
                Text(
                  "(124 Reviews)",
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: textDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: Text("Message",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),

            // Availability Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _settingRow(Icons.directions_walk, "Available for walks",
                        Switch(value: true, onChanged: (_) {})),
                    const Divider(),
                    Text("Walking Pace",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600, color: textDark)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ["Slow", "Medium", "Fast"]
                          .map((p) => ChoiceChip(
                        label: Text(p),
                        selected: p == "Medium",
                        selectedColor: primaryColor,
                        backgroundColor: bgLight,
                        labelStyle: GoogleFonts.plusJakartaSans(
                            color: textDark),
                        onSelected: (_) {},
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text("Languages",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600, color: textDark)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ["English", "Spanish"]
                          .map((l) => Chip(
                        label: Text(l,
                            style: GoogleFonts.plusJakartaSans(
                                color: textDark)),
                        backgroundColor: bgLight,
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text("Interests",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600, color: textDark)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        "Nature",
                        "Photography",
                        "Dogs",
                        "Coffee"
                      ]
                          .map((i) => Chip(
                        label: Text(i,
                            style: GoogleFonts.plusJakartaSans(
                                color: textDark)),
                        backgroundColor: primaryColor.withOpacity(0.2),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.bar_chart, color: Colors.black),
                  title: Text("View Earnings & Stats",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600, color: textDark)),
                  trailing:
                  const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Reviews from Wanderers",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textDark)),
              ),
            ),
            const SizedBox(height: 10),
            _reviewCard(
              name: "Jane Cooper",
              date: "May 20, 2024",
              rating: 5.0,
              comment:
              "Alex was an amazing walking partner! Very friendly and made the walk so enjoyable. Highly recommend!",
              photo:
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCZXcM3i8eLAe_SdfmUg8FUQinIi-eDIg50zgIMcaq9Pv2viUGhcafN7KO8V7az-8o8N_5eaLGn7V-DZ6qU0t1E_U-2MP7n1IeAWEOqMdcJpPrH-r-DQ44oPQZyg0bAiqBQ2Nryg8GNN4IxSLaTGr28XKsrD8OFKF5I6BaWY3bkCCw0_YqTPoxdn7wUNdTh0rCK-_6ZA4gEhVXggwPNwX1AyP1xmF2kTymMAoJ6OEOYajtnH4anRx0WfO0afqDPTMwUR8UNvwn1h70",
            ),
            _reviewCard(
              name: "John Smith",
              date: "May 18, 2024",
              rating: 4.0,
              comment:
              "Great conversation and a pleasant walk through the park. Would walk with Alex again.",
              photo:
              "https://lh3.googleusercontent.com/aida-public/AB6AXuARXLZ323eDS1c8263vfkMscGoABLTbbXispK6zgXWWHzpRzmCuT2dl04i-t0ipNLJx4S6py3vn6RpEI4CRzLu9Ee9qZ_QUdVA6FKJjAvEZT0lChWqxTmBG9BQ_j3CEJMUgQASrP-tSNxHt7hdwEcb_YQch8zzhz7OnO5W5WsThiAk8DMQwGqLMYwXYiPnSqkOvyeAPhWXsZLEbQWe6tU8rpmaaBH46QC2y56LGImQ8W4iY37Ln3BAH1wSFkTFthvvZgTCU4aJWib0",
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingRow(IconData icon, String label, Widget toggle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.plusJakartaSans(color: Colors.black87)),
        ]),
        toggle,
      ],
    );
  }

  Widget _reviewCard({
    required String name,
    required String date,
    required double rating,
    required String comment,
    required String photo,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(photo)),
                  const SizedBox(width: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold)),
                        Text(date,
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.grey[600], fontSize: 12))
                      ])
                ],
              ),
              Row(children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(rating.toString(),
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold))
              ])
            ]),
            const SizedBox(height: 8),
            Text(comment,
                style: GoogleFonts.plusJakartaSans(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
