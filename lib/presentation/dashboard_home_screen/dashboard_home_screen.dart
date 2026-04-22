import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_navigation.dart';
import './widgets/home_active_request_widget.dart';
import './widgets/home_eco_teaser_widget.dart';
import './widgets/home_quick_stats_widget.dart';
import './widgets/home_recent_pickups_widget.dart';
import './widgets/home_request_cta_widget.dart';
import './widgets/home_waste_type_widget.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  int _navIndex = 0;
  bool _hasActiveRequest = true;
  String _selectedWasteType = 'General Waste';

  late AnimationController _entranceController;
  late List<Animation<double>> _sectionAnimations;

  static const List<String> _wasteTypes = [
    'General Waste',
    'Recycling',
    'Yard Waste',
    'Hazardous',
  ];

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _sectionAnimations = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.55).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entranceController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    // TODO: Replace with Riverpod/Bloc for production
    setState(() => _navIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.liveTrackingScreen);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.ecoPointsScreen);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.notificationCenterScreen);
        break;
      case 4:
        Navigator.pushNamed(context, AppRoutes.marketplaceScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
      ),
      bottomNavigationBar: SafeArea(
        child: AppNavigation(currentIndex: _navIndex, onTap: _onNavTap),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildAnimated(
                0,
                _hasActiveRequest
                    ? HomeActiveRequestWidget(
                        onTrack: () => Navigator.pushNamed(
                          context,
                          AppRoutes.liveTrackingScreen,
                        ),
                        onCancel: () =>
                            setState(() => _hasActiveRequest = false),
                      )
                    : HomeRequestCtaWidget(
                        selectedWasteType: _selectedWasteType,
                        onRequest: () =>
                            setState(() => _hasActiveRequest = true),
                      ),
              ),
              const SizedBox(height: 20),
              _buildAnimated(
                1,
                HomeWasteTypeWidget(
                  wasteTypes: _wasteTypes,
                  selectedType: _selectedWasteType,
                  onTypeSelected: (t) => setState(() => _selectedWasteType = t),
                ),
              ),
              const SizedBox(height: 20),
              _buildAnimated(2, const HomeQuickStatsWidget()),
              const SizedBox(height: 20),
              _buildAnimated(3, HomeRecentPickupsWidget(onViewAll: () {})),
              const SizedBox(height: 20),
              _buildAnimated(
                4,
                HomeEcoTeaserWidget(
                  onViewPoints: () =>
                      Navigator.pushNamed(context, AppRoutes.ecoPointsScreen),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
          sliver: SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildAnimated(
                        0,
                        _hasActiveRequest
                            ? HomeActiveRequestWidget(
                                onTrack: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.liveTrackingScreen,
                                ),
                                onCancel: () =>
                                    setState(() => _hasActiveRequest = false),
                              )
                            : HomeRequestCtaWidget(
                                selectedWasteType: _selectedWasteType,
                                onRequest: () =>
                                    setState(() => _hasActiveRequest = true),
                              ),
                      ),
                      const SizedBox(height: 20),
                      _buildAnimated(
                        1,
                        HomeWasteTypeWidget(
                          wasteTypes: _wasteTypes,
                          selectedType: _selectedWasteType,
                          onTypeSelected: (t) =>
                              setState(() => _selectedWasteType = t),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildAnimated(
                        3,
                        HomeRecentPickupsWidget(onViewAll: () {}),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildAnimated(2, const HomeQuickStatsWidget()),
                      const SizedBox(height: 20),
                      _buildAnimated(
                        4,
                        HomeEcoTeaserWidget(
                          onViewPoints: () => Navigator.pushNamed(
                            context,
                            AppRoutes.ecoPointsScreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimated(int index, Widget child) {
    return FadeTransition(
      opacity: _sectionAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(_sectionAnimations[index]),
        child: child,
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 0,
      backgroundColor: AppTheme.primaryGreen,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B5E20), AppTheme.primaryGreen],
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.recycling_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'EcoBin',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.notificationCenterScreen,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFF57F17),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white.withAlpha(64),
            child: Text(
              'MC',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
