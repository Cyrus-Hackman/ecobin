import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class AppNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _pillController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _pillController, curve: Curves.easeOutBack),
    );
    _pillController.forward();
  }

  @override
  void didUpdateWidget(AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _pillController.reset();
      _pillController.forward();
    }
  }

  @override
  void dispose() {
    _pillController.dispose();
    super.dispose();
  }

  static const List<_NavItem> _items = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.local_shipping_outlined,
      activeIcon: Icons.local_shipping_rounded,
      label: 'Track',
    ),
    _NavItem(
      icon: Icons.eco_outlined,
      activeIcon: Icons.eco_rounded,
      label: 'Eco',
    ),
    _NavItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications_rounded,
      label: 'Alerts',
    ),
    _NavItem(
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront_rounded,
      label: 'Market',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withAlpha(46),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isActive = widget.currentIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onTap(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isActive ? _scaleAnimation.value : 1.0,
                      child: child,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppTheme.primaryGreen.withAlpha(31)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          isActive ? item.activeIcon : item.icon,
                          size: 22,
                          color: isActive
                              ? AppTheme.primaryGreen
                              : AppTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isActive
                              ? AppTheme.primaryGreen
                              : AppTheme.textMuted,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// Tablet NavigationRail variant
class AppNavigationRail extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavigationRail({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      elevation: 2,
      extended: MediaQuery.of(context).size.width >= 840,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.recycling_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
      indicatorColor: AppTheme.primaryGreen.withAlpha(31),
      selectedIconTheme: const IconThemeData(
        color: AppTheme.primaryGreen,
        size: 22,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppTheme.textMuted,
        size: 22,
      ),
      selectedLabelTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryGreen,
      ),
      unselectedLabelTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppTheme.textMuted,
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.local_shipping_outlined),
          selectedIcon: Icon(Icons.local_shipping_rounded),
          label: Text('Track'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.eco_outlined),
          selectedIcon: Icon(Icons.eco_rounded),
          label: Text('Eco'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications_rounded),
          label: Text('Alerts'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.storefront_outlined),
          selectedIcon: Icon(Icons.storefront_rounded),
          label: Text('Market'),
        ),
      ],
    );
  }
}
