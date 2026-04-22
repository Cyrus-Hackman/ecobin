import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_navigation.dart';
import './widgets/notification_filter_widget.dart';
import './widgets/notification_list_widget.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  int _navIndex = 3;
  String _selectedFilter = 'All';
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;

  static const List<String> _filters = [
    'All',
    'Pickups',
    'Eco Rewards',
    'Alerts',
  ];

  static final List<Map<String, dynamic>> _notificationMaps = [
    {
      'id': '1',
      'type': 'Pickups',
      'title': 'Truck is 5 minutes away!',
      'body':
          'Your General Waste pickup #ECO-2847 is almost there. Please have your bins ready.',
      'time': '2:40 PM',
      'date': 'Today',
      'isRead': false,
      'icon': 'local_shipping_rounded',
      'color': 'orange',
    },
    {
      'id': '2',
      'type': 'Pickups',
      'title': 'Pickup confirmed',
      'body':
          'Your recycling pickup #ECO-2847 has been confirmed. ETA: 12 minutes.',
      'time': '2:28 PM',
      'date': 'Today',
      'isRead': false,
      'icon': 'check_circle_outline_rounded',
      'color': 'purple',
    },
    {
      'id': '3',
      'type': 'Eco Rewards',
      'title': 'You earned 120 Eco Points! 🎉',
      'body':
          'Your recycling pickup was processed. 2.4 kg of recyclables diverted from landfill.',
      'time': '11:05 AM',
      'date': 'Today',
      'isRead': true,
      'icon': 'stars_rounded',
      'color': 'gold',
    },
    {
      'id': '4',
      'type': 'Eco Rewards',
      'title': 'Badge unlocked: Recycling Hero',
      'body':
          'You\'ve completed 10 recycling pickups. Keep up the great eco work!',
      'time': '9:30 AM',
      'date': 'Today',
      'isRead': true,
      'icon': 'emoji_events_rounded',
      'color': 'gold',
    },
    {
      'id': '5',
      'type': 'Pickups',
      'title': 'Pickup completed successfully',
      'body':
          'Your Yard Waste pickup #ECO-2831 was completed. You earned 80 Eco Points.',
      'time': '10:22 AM',
      'date': 'Yesterday',
      'isRead': true,
      'icon': 'task_alt_rounded',
      'color': 'green',
    },
    {
      'id': '6',
      'type': 'Alerts',
      'title': 'Service update in your area',
      'body':
          'Pickup services may be delayed on Apr 18 due to scheduled road maintenance on Elm Street.',
      'time': '8:00 AM',
      'date': 'Yesterday',
      'isRead': true,
      'icon': 'info_outline_rounded',
      'color': 'blue',
    },
    {
      'id': '7',
      'type': 'Eco Rewards',
      'title': 'Weekly eco summary',
      'body':
          'This week you diverted 5.8 kg of recyclables and saved 3.2 kg of CO₂. You\'re a Sapling!',
      'time': '7:00 AM',
      'date': 'Yesterday',
      'isRead': true,
      'icon': 'eco_rounded',
      'color': 'green',
    },
    {
      'id': '8',
      'type': 'Alerts',
      'title': 'Hazardous waste day reminder',
      'body':
          'Special collection for hazardous waste items scheduled for Apr 20 in your zone.',
      'time': '9:00 AM',
      'date': 'Earlier',
      'isRead': true,
      'icon': 'warning_amber_rounded',
      'color': 'orange',
    },
    {
      'id': '9',
      'type': 'Pickups',
      'title': 'Pickup cancelled',
      'body':
          'Your General Waste pickup #ECO-2790 was cancelled due to driver unavailability. Please reschedule.',
      'time': '3:15 PM',
      'date': 'Earlier',
      'isRead': true,
      'icon': 'cancel_outlined',
      'color': 'red',
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    if (_selectedFilter == 'All') return _notificationMaps;
    return _notificationMaps
        .where((n) => n['type'] == _selectedFilter)
        .toList();
  }

  int get _unreadCount =>
      _notificationMaps.where((n) => !(n['isRead'] as bool)).length;

  void _markAllRead() {
    // TODO: Replace with Riverpod/Bloc for production
    setState(() {
      for (final n in _notificationMaps) {
        n['isRead'] = true;
      }
    });
  }

  void _dismissNotification(String id) {
    // TODO: Replace with Riverpod/Bloc for production
    setState(() {
      _notificationMaps.removeWhere((n) => n['id'] == id);
    });
  }

  void _onNavTap(int index) {
    setState(() => _navIndex = index);
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashboardHomeScreen,
          (r) => false,
        );
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.liveTrackingScreen);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.ecoPointsScreen);
        break;
      case 3:
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.marketplaceScreen);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final filtered = _filteredNotifications;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: isTablet
              ? _buildTabletLayout(filtered)
              : _buildPhoneLayout(filtered),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AppNavigation(currentIndex: _navIndex, onTap: _onNavTap),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B5E20), AppTheme.primaryGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Notifications',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_unreadCount > 0)
                  TextButton(
                    onPressed: _markAllRead,
                    child: Text(
                      'Mark all read',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout(List<Map<String, dynamic>> filtered) {
    return Column(
      children: [
        NotificationFilterWidget(
          filters: _filters,
          selectedFilter: _selectedFilter,
          unreadCount: _unreadCount,
          onFilterSelected: (f) => setState(() => _selectedFilter = f),
        ),
        Expanded(
          child: NotificationListWidget(
            notifications: filtered,
            onDismiss: _dismissNotification,
            onTap: (id) {
              // TODO: Replace with Riverpod/Bloc for production
              setState(() {
                final idx = _notificationMaps.indexWhere((n) => n['id'] == id);
                if (idx != -1) _notificationMaps[idx]['isRead'] = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(List<Map<String, dynamic>> filtered) {
    return Row(
      children: [
        SizedBox(
          width: 280,
          child: NotificationFilterWidget(
            filters: _filters,
            selectedFilter: _selectedFilter,
            unreadCount: _unreadCount,
            onFilterSelected: (f) => setState(() => _selectedFilter = f),
            vertical: true,
          ),
        ),
        Expanded(
          child: NotificationListWidget(
            notifications: filtered,
            onDismiss: _dismissNotification,
            onTap: (id) {
              setState(() {
                final idx = _notificationMaps.indexWhere((n) => n['id'] == id);
                if (idx != -1) _notificationMaps[idx]['isRead'] = true;
              });
            },
          ),
        ),
      ],
    );
  }
}
