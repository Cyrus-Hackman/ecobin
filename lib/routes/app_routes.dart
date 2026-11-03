import 'package:flutter/material.dart';

import '../presentation/dashboard_home_screen/dashboard_home_screen.dart';
import '../presentation/eco_points_screen/eco_points_screen.dart';
import '../presentation/live_tracking_screen/live_tracking_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/marketplace_screen/marketplace_screen.dart';
import '../presentation/notification_center_screen/notification_center_screen.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/collector/dashboard/collector_dashboard_screen.dart';
import '../presentation/collector/live_requests/live_requests_screen.dart';
import '../presentation/collector/routing/active_route_map_screen.dart';
import '../presentation/collector/camera/proof_of_pickup_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String loginScreen = '/login-screen';
  static const String registrationScreen = '/registration-screen';
  static const String dashboardHomeScreen = '/dashboard-home-screen';
  static const String liveTrackingScreen = '/live-tracking-screen';
  static const String notificationCenterScreen = '/notification-center-screen';
  static const String ecoPointsScreen = '/eco-points-screen';
  static const String marketplaceScreen = '/marketplace-screen';
  
  static const String collectorDashboardScreen = '/collector-dashboard-screen';
  static const String liveRequestsScreen = '/live-requests-screen';
  static const String activeRouteMapScreen = '/active-route-map-screen';
  static const String proofOfPickupScreen = '/proof-of-pickup-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    loginScreen: (context) => const LoginScreen(),
    registrationScreen: (context) => const RegistrationScreen(),
    dashboardHomeScreen: (context) => const DashboardHomeScreen(),
    liveTrackingScreen: (context) => const LiveTrackingScreen(),
    notificationCenterScreen: (context) => const NotificationCenterScreen(),
    ecoPointsScreen: (context) => const EcoPointsScreen(),
    marketplaceScreen: (context) => const MarketplaceScreen(),
    collectorDashboardScreen: (context) => const CollectorDashboardScreen(),
    liveRequestsScreen: (context) => const LiveRequestsScreen(),
    activeRouteMapScreen: (context) => const ActiveRouteMapScreen(),
    proofOfPickupScreen: (context) => const ProofOfPickupScreen(),
  };
}
