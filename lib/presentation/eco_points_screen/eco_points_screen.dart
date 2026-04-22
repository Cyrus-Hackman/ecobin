import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_navigation.dart';
import './widgets/eco_activity_log_widget.dart';
import './widgets/eco_badges_widget.dart';
import './widgets/eco_impact_stats_widget.dart';
import './widgets/eco_points_hero_widget.dart';

class EcoPointsScreen extends StatefulWidget {
  const EcoPointsScreen({super.key});

  @override
  State<EcoPointsScreen> createState() => _EcoPointsScreenState();
}

class _EcoPointsScreenState extends State<EcoPointsScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  int _navIndex = 2;
  late AnimationController _entranceController;
  late List<Animation<double>> _sectionAnimations;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _sectionAnimations = List.generate(4, (i) {
      final start = i * 0.15;
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
      appBar: _buildAppBar(),
      body: SafeArea(
        child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
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
                    'Eco Points',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildPhoneLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        children: [
          _buildAnimated(0, const EcoPointsHeroWidget()),
          const SizedBox(height: 20),
          _buildAnimated(1, const EcoBadgesWidget()),
          const SizedBox(height: 20),
          _buildAnimated(2, const EcoImpactStatsWidget()),
          const SizedBox(height: 20),
          _buildAnimated(3, const EcoActivityLogWidget()),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
      child: Column(
        children: [
          _buildAnimated(0, const EcoPointsHeroWidget()),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildAnimated(1, const EcoBadgesWidget()),
                    const SizedBox(height: 20),
                    _buildAnimated(3, const EcoActivityLogWidget()),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: _buildAnimated(2, const EcoImpactStatsWidget()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
