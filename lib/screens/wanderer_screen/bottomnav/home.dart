import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../colors/MyColors.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Hi, Aryan 👋".text.xl3.semiBold.make(),
              const Icon(Icons.notifications_none_rounded, size: 28),
            ],
          ),
          const SizedBox(height: 16),

          // search bar
          TextField(
            decoration: InputDecoration(
              hintText: "Where would you like to walk?",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Map image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/mapsample.png', // Replace with your map image
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.useYellow,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on_outlined),
                  label: "Instant Walk".text.semiBold.xl.make(),
                ).h(75),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {Navigator.pushNamed(context, '/scheduleWalk');},
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: "Schedule Walk".text.xl.semiBold.make(),
                ).h(75),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.people_outline),
                  label: "Find Companion".text.xl.make(),
                ).h(75),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.message_outlined),
                  label: "Messages".text.xl.make(),
                ).h(75),
              ),
            ],
          ),
          const SizedBox(height: 24),

          "Your Progress".text.xl2.semiBold.make(),
          const SizedBox(height: 12),
          // chart or progress placeholder
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: "Progress Chart Coming Soon".text.gray500.make(),
            ),
          ),
        ],
      ),
    );
  }
}
