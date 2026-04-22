import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

enum PickupStatus {
  requested,
  confirmed,
  enRoute,
  arrived,
  completed,
  cancelled,
}

class StatusBadgeWidget extends StatelessWidget {
  final PickupStatus status;
  final bool compact;

  const StatusBadgeWidget({
    super.key,
    required this.status,
    this.compact = false,
  });

  static Color _bgColor(PickupStatus s) {
    switch (s) {
      case PickupStatus.requested:
        return AppTheme.statusRequested.withAlpha(31);
      case PickupStatus.confirmed:
        return AppTheme.statusConfirmed.withAlpha(31);
      case PickupStatus.enRoute:
        return AppTheme.statusEnRoute.withAlpha(31);
      case PickupStatus.arrived:
        return AppTheme.statusArrived.withAlpha(31);
      case PickupStatus.completed:
        return AppTheme.success.withAlpha(31);
      case PickupStatus.cancelled:
        return AppTheme.error.withAlpha(31);
    }
  }

  static Color _textColor(PickupStatus s) {
    switch (s) {
      case PickupStatus.requested:
        return AppTheme.statusRequested;
      case PickupStatus.confirmed:
        return AppTheme.statusConfirmed;
      case PickupStatus.enRoute:
        return AppTheme.statusEnRoute;
      case PickupStatus.arrived:
        return AppTheme.statusArrived;
      case PickupStatus.completed:
        return AppTheme.success;
      case PickupStatus.cancelled:
        return AppTheme.error;
    }
  }

  static String _label(PickupStatus s) {
    switch (s) {
      case PickupStatus.requested:
        return 'Requested';
      case PickupStatus.confirmed:
        return 'Confirmed';
      case PickupStatus.enRoute:
        return 'En Route';
      case PickupStatus.arrived:
        return 'Arrived';
      case PickupStatus.completed:
        return 'Completed';
      case PickupStatus.cancelled:
        return 'Cancelled';
    }
  }

  static IconData _icon(PickupStatus s) {
    switch (s) {
      case PickupStatus.requested:
        return Icons.schedule_rounded;
      case PickupStatus.confirmed:
        return Icons.check_circle_outline_rounded;
      case PickupStatus.enRoute:
        return Icons.local_shipping_rounded;
      case PickupStatus.arrived:
        return Icons.location_on_rounded;
      case PickupStatus.completed:
        return Icons.task_alt_rounded;
      case PickupStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = _bgColor(status);
    final tc = _textColor(status);
    final label = _label(status);
    final icon = _icon(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 10 : 12, color: tc),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: tc,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
