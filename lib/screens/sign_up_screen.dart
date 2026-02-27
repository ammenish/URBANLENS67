import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../main_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String role;
  const SignUpScreen({super.key, required this.role});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeTerms = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _signUp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          // Orange gradient at top
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryOrange.withValues(alpha: 0.4),
                    AppTheme.primaryOrange.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Back button
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
                    SizedBox(height: 30),
                    // Title
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.charcoal,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Fill your information below or register\nwith your social account',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppTheme.darkGrey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36),
                    // Name field
                    Text(
                      'Name',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.charcoal,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: AppTheme.inputDecoration(
                        label: '',
                        hint: 'Esther Howard',
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email field
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.charcoal,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppTheme.inputDecoration(
                        label: '',
                        hint: 'example@gmail.com',
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password field
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.charcoal,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppTheme.inputDecoration(
                        label: '',
                        hint: '••••••••••••',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.darkGrey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Terms checkbox
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              setState(() => _agreeTerms = !_agreeTerms),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: _agreeTerms
                                  ? AppTheme.primaryOrange
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _agreeTerms
                                    ? AppTheme.primaryOrange
                                    : AppTheme.mediumGrey,
                                width: 2,
                              ),
                            ),
                            child: _agreeTerms
                                ? Icon(Icons.check,
                                    size: 16, color: AppTheme.white)
                                : null,
                          ),
                        ),
                        SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Agree with ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppTheme.darkGrey,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Condition',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppTheme.primaryOrange,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: AppTheme.primaryButton,
                        child: Text('Sign Up', style: AppTheme.buttonText),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                              color: AppTheme.mediumGrey.withValues(alpha: 0.3)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or sign up with',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.darkGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                              color: AppTheme.mediumGrey.withValues(alpha: 0.3)),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.apple),
                        SizedBox(width: 16),
                        _buildSocialButton(Icons.g_mobiledata),
                        SizedBox(width: 16),
                        _buildSocialButton(Icons.facebook),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Already have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppTheme.darkGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppTheme.primaryOrange,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppTheme.primaryOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.mediumGrey.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 28, color: AppTheme.charcoal),
    );
  }
}
