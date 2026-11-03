import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';

class LiveRequestsScreen extends StatefulWidget {
  const LiveRequestsScreen({super.key});

  @override
  State<LiveRequestsScreen> createState() => _LiveRequestsScreenState();
}

class _LiveRequestsScreenState extends State<LiveRequestsScreen> {
  final List<Map<String, dynamic>> _mockRequests = [
    {
      'id': 'REQ-1002',
      'user': 'Alice Smith',
      'address': '123 Maple Street, Green Valley',
      'distance': '1.2 km',
      'type': 'Recyclables',
      'status': 'pending',
    },
    {
      'id': 'REQ-1003',
      'user': 'John Doe',
      'address': '45 Oak Lane, Downtown',
      'distance': '2.5 km',
      'type': 'Organic Waste',
      'status': 'pending',
    },
    {
      'id': 'REQ-1004',
      'user': 'Sarah Connor',
      'address': '789 Pine Ave, Westside',
      'distance': '3.1 km',
      'type': 'Mixed Waste',
      'status': 'pending',
    },
  ];

  void _acceptRequest(int index) {
    setState(() {
      _mockRequests[index]['status'] = 'accepted';
    });
    
    // Navigate to Route Map immediately for demonstration
    Navigator.pushNamed(context, AppRoutes.activeRouteMapScreen);
  }

  void _declineRequest(int index) {
    setState(() {
      _mockRequests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingRequests = _mockRequests.where((r) => r['status'] == 'pending').toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        title: Text(
          'Live Requests',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: pendingRequests.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_rounded, size: 64, color: AppTheme.textMuted.withAlpha(100)),
                  const SizedBox(height: 16),
                  Text(
                    'No new requests in your area.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pendingRequests.length,
              itemBuilder: (context, index) {
                final req = pendingRequests[index];
                // Find original index
                final originalIndex = _mockRequests.indexWhere((r) => r['id'] == req['id']);
                
                return _buildRequestCard(req, originalIndex);
              },
            ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request, int originalIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(left: BorderSide(color: AppTheme.primaryGreen, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pickup ${request['id']}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.info.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.near_me_rounded, size: 14, color: AppTheme.info),
                    const SizedBox(width: 4),
                    Text(
                      request['distance'],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.info,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.person_rounded, size: 20, color: AppTheme.textMuted),
              const SizedBox(width: 8),
              Text(
                request['user'],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_rounded, size: 20, color: AppTheme.textMuted),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  request['address'],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.delete_outline_rounded, size: 20, color: AppTheme.textMuted),
              const SizedBox(width: 8),
              Text(
                request['type'],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _declineRequest(originalIndex),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.error,
                    side: const BorderSide(color: AppTheme.error),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Decline',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _acceptRequest(originalIndex),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
