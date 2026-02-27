import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'sign_in_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _selectRole(String role) {
    setState(() => _selectedRole = role);
    Future.delayed(Duration(milliseconds: 400), () {
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignInScreen(role: role),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  // Header with logo
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios_new, size: 18),
                          color: AppTheme.charcoal,
                        ),
                      ),
                      Spacer(),
                      // App logo badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.pureBlack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/logo.jpg',
                                width: 22,
                                height: 22,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'UrbanLens',
                              style: GoogleFonts.poppins(
                                color: AppTheme.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  // Title
                  Text(
                    'How do you want to\nuse UrbanLens?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.charcoal,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 50),
                  // Architect Option
                  _buildRoleCard(
                    role: 'Architect',
                    icon: Icons.architecture_rounded,
                    description: 'Design & visualize projects',
                    isSelected: _selectedRole == 'Architect',
                    gradient: [
                      AppTheme.primaryOrange.withValues(alpha: 0.1),
                      AppTheme.primaryOrange.withValues(alpha: 0.05),
                    ],
                    iconBg: AppTheme.primaryOrange,
                  ),
                  SizedBox(height: 16),
                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.mediumGrey.withValues(alpha: 0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: GoogleFonts.poppins(
                            color: AppTheme.mediumGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: AppTheme.mediumGrey.withValues(alpha: 0.3))),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Investor Option
                  _buildRoleCard(
                    role: 'Investor',
                    icon: Icons.business_rounded,
                    description: 'Fund & track investments',
                    isSelected: _selectedRole == 'Investor',
                    gradient: [
                      AppTheme.charcoal.withValues(alpha: 0.05),
                      AppTheme.charcoal.withValues(alpha: 0.02),
                    ],
                    iconBg: AppTheme.charcoal,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String description,
    required bool isSelected,
    required List<Color> gradient,
    required Color iconBg,
  }) {
    return GestureDetector(
      onTap: () => _selectRole(role),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [AppTheme.primaryOrange.withValues(alpha: 0.15), AppTheme.primaryOrange.withValues(alpha: 0.05)]
                : gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(
            color: isSelected ? AppTheme.primaryOrange : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? AppTheme.elevatedShadow : AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryOrange : iconBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: AppTheme.white,
                size: 40,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.charcoal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppTheme.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.primaryOrange : AppTheme.lightGrey,
              ),
              child: Icon(
                isSelected ? Icons.check : Icons.arrow_forward_ios,
                color: isSelected ? AppTheme.white : AppTheme.darkGrey,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
