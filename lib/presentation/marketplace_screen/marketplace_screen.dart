import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_navigation.dart';
import './widgets/marketplace_category_filter_widget.dart';
import './widgets/marketplace_points_header_widget.dart';
import './widgets/marketplace_reward_card_widget.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen>
    with SingleTickerProviderStateMixin {
  int _navIndex = 4;
  String _selectedCategory = 'All';
  int _userPoints = 1240;

  late AnimationController _entranceController;
  late List<Animation<double>> _sectionAnimations;

  static final List<MarketplaceRewardItem> _allRewards = [
    MarketplaceRewardItem(
      id: '1',
      title: '20% Off at GreenGrocer',
      vendor: 'GreenGrocer Market',
      description: 'Get 20% off your next purchase of fresh organic produce.',
      pointsCost: 300,
      category: 'Discounts',
      imageUrl:
          'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400',
      tag: 'Popular',
      tagColor: AppTheme.primaryGreen,
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '2',
      title: 'Free Coffee at EcoCafe',
      vendor: 'EcoCafe Downtown',
      description: 'Enjoy a complimentary barista coffee of your choice.',
      pointsCost: 150,
      category: 'Vendors',
      imageUrl:
          'https://images.pixabay.com/photo/2016/11/29/12/54/cafe-1869656_640.jpg',
      tag: 'Hot Deal',
      tagColor: const Color(0xFFF57F17),
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '3',
      title: '\$5 App Credit',
      vendor: 'EcoBin Platform',
      description: 'Apply \$5 credit toward your next pickup service fee.',
      pointsCost: 500,
      category: 'App Credits',
      imageUrl:
          'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&auto=format&fit=crop',
      tag: 'Credit',
      tagColor: AppTheme.info,
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '4',
      title: 'Compost Bin Kit',
      vendor: 'EcoSupplies Co.',
      description: 'A starter home composting kit with guides and tools.',
      pointsCost: 800,
      category: 'Vendors',
      imageUrl:
          'https://images.pexels.com/photos/4503273/pexels-photo-4503273.jpeg?auto=compress&cs=tinysrgb&w=400',
      tag: 'Eco Pick',
      tagColor: AppTheme.secondaryLime,
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '5',
      title: '15% Off Bike Rental',
      vendor: 'GreenRide Rentals',
      description: 'Discount on a full-day eco-friendly bike rental.',
      pointsCost: 250,
      category: 'Discounts',
      imageUrl:
          'https://images.pixabay.com/photo/2017/09/14/11/07/bicycle-2749505_640.jpg',
      tag: 'New',
      tagColor: AppTheme.statusConfirmed,
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '6',
      title: '\$10 App Credit',
      vendor: 'EcoBin Platform',
      description:
          'Apply \$10 credit toward any EcoBin service or subscription.',
      pointsCost: 950,
      category: 'App Credits',
      imageUrl:
          'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=400&auto=format&fit=crop',
      tag: 'Best Value',
      tagColor: AppTheme.earthyBrown,
      isAvailable: false,
    ),
    MarketplaceRewardItem(
      id: '7',
      title: 'Free Yoga Class',
      vendor: 'Zen Wellness Studio',
      description: 'One complimentary yoga or meditation session.',
      pointsCost: 400,
      category: 'Vendors',
      imageUrl:
          'https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&cs=tinysrgb&w=400',
      tag: 'Wellness',
      tagColor: const Color(0xFF6A1B9A),
      isAvailable: true,
    ),
    MarketplaceRewardItem(
      id: '8',
      title: '30% Off Farmers Market',
      vendor: 'City Farmers Market',
      description: 'Discount voucher valid at any stall at the weekly market.',
      pointsCost: 350,
      category: 'Discounts',
      imageUrl:
          'https://images.pixabay.com/photo/2016/08/11/08/04/vegetables-1584999_640.jpg',
      tag: 'Community',
      tagColor: AppTheme.primaryGreen,
      isAvailable: true,
    ),
  ];

  List<MarketplaceRewardItem> get _filteredRewards {
    if (_selectedCategory == 'All') return _allRewards;
    return _allRewards.where((r) => r.category == _selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _sectionAnimations = List.generate(3, (i) {
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
        Navigator.pushNamed(context, AppRoutes.ecoPointsScreen);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.notificationCenterScreen);
        break;
      case 4:
        break;
    }
  }

  void _onRedeem(MarketplaceRewardItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.eco_rounded,
                color: AppTheme.primaryGreen,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Redeem Reward',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'from ${item.vendor}',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.eco_rounded,
                    color: AppTheme.primaryGreen,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${item.pointsCost} Eco-Points will be deducted',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: AppTheme.textMuted,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _userPoints -= item.pointsCost);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${item.title} redeemed! Check your email.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: AppTheme.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final rewards = _filteredRewards;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                isTablet ? 24 : 20,
                16,
                isTablet ? 24 : 20,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimated(
                      0,
                      MarketplacePointsHeaderWidget(points: _userPoints),
                    ),
                    const SizedBox(height: 20),
                    _buildAnimated(
                      1,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Browse Rewards',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          MarketplaceCategoryFilterWidget(
                            selectedCategory: _selectedCategory,
                            onCategorySelected: (cat) =>
                                setState(() => _selectedCategory = cat),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                isTablet ? 24 : 20,
                0,
                isTablet ? 24 : 20,
                100,
              ),
              sliver: _buildAnimated(
                2,
                rewards.isEmpty
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.storefront_outlined,
                                  size: 48,
                                  color: AppTheme.textMuted,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No rewards in this category',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => MarketplaceRewardCardWidget(
                            item: rewards[index],
                            userPoints: _userPoints,
                            onRedeem: () => _onRedeem(rewards[index]),
                          ),
                          childCount: rewards.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 3 : 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: isTablet ? 0.72 : 0.65,
                        ),
                      ),
              ),
            ),
          ],
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
                    'Marketplace',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.eco_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$_userPoints pts',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
