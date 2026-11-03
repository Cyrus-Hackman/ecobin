
import '../../core/app_export.dart';
import './widgets/registration_form_widget.dart';
import './widgets/registration_header_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;
  bool _termsAccepted = false;
  String _selectedRole = 'User';

  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _postalCtrl.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms & Privacy Policy to continue',
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
          ),
          backgroundColor: AppTheme.warning,
        ),
      );
      return;
    }
    // TODO: Replace with Riverpod/Bloc for production
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) {
      setState(() => _isLoading = false);
      final route = _selectedRole == 'Collector'
          ? AppRoutes.collectorDashboardScreen
          : AppRoutes.dashboardHomeScreen;
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (r) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Column(
      children: [
        RegistrationHeaderWidget(onBack: () => Navigator.pop(context)),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: RegistrationFormWidget(
              formKey: _formKey,
              firstNameCtrl: _firstNameCtrl,
              lastNameCtrl: _lastNameCtrl,
              emailCtrl: _emailCtrl,
              phoneCtrl: _phoneCtrl,
              passwordCtrl: _passwordCtrl,
              confirmPasswordCtrl: _confirmPasswordCtrl,
              streetCtrl: _streetCtrl,
              cityCtrl: _cityCtrl,
              postalCtrl: _postalCtrl,
              termsAccepted: _termsAccepted,
              selectedRole: _selectedRole,
              isLoading: _isLoading,
              onTermsChanged: (v) =>
                  setState(() => _termsAccepted = v ?? false),
              onRoleChanged: (r) => setState(() => _selectedRole = r ?? 'User'),
              onSubmit: _handleRegister,
              isTablet: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          children: [
            RegistrationHeaderWidget(onBack: () => Navigator.pop(context)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 32),
                child: RegistrationFormWidget(
                  formKey: _formKey,
                  firstNameCtrl: _firstNameCtrl,
                  lastNameCtrl: _lastNameCtrl,
                  emailCtrl: _emailCtrl,
                  phoneCtrl: _phoneCtrl,
                  passwordCtrl: _passwordCtrl,
                  confirmPasswordCtrl: _confirmPasswordCtrl,
                  streetCtrl: _streetCtrl,
                  cityCtrl: _cityCtrl,
                  postalCtrl: _postalCtrl,
                  termsAccepted: _termsAccepted,
                  selectedRole: _selectedRole,
                  isLoading: _isLoading,
                  onTermsChanged: (v) =>
                      setState(() => _termsAccepted = v ?? false),
                  onRoleChanged: (r) =>
                      setState(() => _selectedRole = r ?? 'User'),
                  onSubmit: _handleRegister,
                  isTablet: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
