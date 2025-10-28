import 'package:aidkriya/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  // --- Map and Location State ---
  GoogleMapController? mapController;
  LatLng? _currentPosition;
  bool _isLoadingMap = true; // Added loading state for initial fetch

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Clean up the map controller when the widget is disposed
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  // --- Location and Permission Logic (Copied from your map widget) ---
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoadingMap = false;
      });
      // Try to animate the camera if controller is already available
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
      );
    } catch (e) {
      print('Location Error: $e');
      setState(() {
        _isLoadingMap = false;
        // Optionally set a default location if access is denied
        _currentPosition = const LatLng(37.7749, -122.4194); // Default to San Francisco
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // --- Walk Request Card Builder (Unchanged) ---
  Widget _buildWalkRequestCard({
    required String name,
    required String distance,
    required String requestedTime,
    required String imageUrl,
  }) {
    // A Card widget is used for each request for a nice, elevated look
    return Card(
      color: MyColors.darkSurface,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User details and buttons column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    distance,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Requested Time: $requestedTime',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Accept/Decline Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.yellow, // Blue color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text('Accept', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.white.withOpacity(0.3)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text('Decline', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              radius: 58,
              backgroundColor: MyColors.darkPlaceholder,
              backgroundImage: AssetImage(imageUrl),
            ),

          ],
        ),
      ),
    );
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    // 🛑 Note: We are keeping the Scaffold and setting its background to a dark color.
    return Scaffold(
      backgroundColor: MyColors.darkBackground, // Use the proper dark color
      body: Stack(
        children: <Widget>[
          // 1. Live Map View (Replaces Placeholder)
          Container(
            height: MediaQuery.of(context).size.height * 0.5, // Map covers the top half
            color: MyColors.darkBackground, // Ensures dark background before map loads
            child: _isLoadingMap || _currentPosition == null
                ? Center(
              // Show a progress indicator while waiting for location data
              child: CircularProgressIndicator(color: MyColors.accentBlue),
            )
                : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                    // Move camera only if position is available
                    if (_currentPosition != null) {
                      controller.animateCamera(
                        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
                      );
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: _currentPosition!,
                      infoWindow: const InfoWindow(title: 'You are here'),
                    ),
                  },
                ),
                // Dark overlay to make UI elements pop
                Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
          ),

          // 2. Search Bar
          Positioned(
            top: 60.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  hintText: 'Search for a location',
                  hintStyle: TextStyle(color: Colors.black87),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          // 3. Floating Action Buttons (Zoom & Center Location) - Needs mapController access to function
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5 - 30,
            right: 14.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Plus button
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: MyColors.darkSurface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      // Functionality to zoom in
                      mapController?.animateCamera(CameraUpdate.zoomIn());
                    },
                  ),
                ),
                // Minus button
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: MyColors.darkSurface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      // Functionality to zoom out
                      mapController?.animateCamera(CameraUpdate.zoomOut());
                    },
                  ),
                ),
                // Center/Recenter Location button
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.darkSurface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.navigation, color: Colors.white),
                    onPressed: () {
                      // Functionality to recenter the map
                      if (_currentPosition != null) {
                        mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(_currentPosition!, 15),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // 4. "Start Normal Walk" Button
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5 - 30, // Aligned with the floating buttons
            left: 16.0,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.pets, color: Colors.white),
              label: const Text(
                'Start Normal Walk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.yellow,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),

          // 5. New Walk Requests Section (Scrollable)
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: MyColors.darkBackground,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Drag handle for the sheet
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Section Title
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          'New Walk Requests',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Request Cards
                      _buildWalkRequestCard(
                        name: 'Jenna Ortega',
                        distance: '0.5 miles away',
                        requestedTime: '04:30 PM',
                        imageUrl: 'assets/pfsample.png', // Placeholder
                      ),
                      _buildWalkRequestCard(
                        name: 'Aayush Nagar',
                        distance: '1.2 miles away',
                        requestedTime: '05:00 PM',
                        imageUrl: 'assets/pfsample1.png', // Placeholder
                      ),
                      _buildWalkRequestCard(
                        name: 'Ishika ',
                        distance: '1.2 miles away',
                        requestedTime: '05:00 PM',
                        imageUrl: 'assets/pfsample2.png', // Placeholder
                      ),
                      // Add some padding at the bottom so the last card isn't covered by the nav bar
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}