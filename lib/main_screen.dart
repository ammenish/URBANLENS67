import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_lens/theme.dart';
import 'package:urban_lens/screens/dashboard_screen.dart';
import 'package:urban_lens/screens/community_screen.dart';
import 'package:urban_lens/screens/explore_screen.dart';
import 'package:urban_lens/screens/projects_screen.dart';
import 'package:urban_lens/screens/help_screen.dart';
import 'package:urban_lens/screens/whats_new_screen.dart';
import 'package:urban_lens/screens/ar_camera_screen.dart';
import 'package:urban_lens/screens/live_view_screen.dart';
import 'package:urban_lens/screens/splash_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    DashboardScreen(),
    ArCameraScreen(),
    SizedBox(), // placeholder for center button
    LiveViewScreen(),
    CommunityScreen(),
  ];

  void _onNavTap(int index) {
    if (index == 2) {
      _showCreateProjectSheet();
      return;
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ArCameraScreen()),
      );
      return;
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LiveViewScreen()),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void _showCreateProjectSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _CreateProjectSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayIndex = (_currentIndex == 4) ? 4 : _currentIndex;
    final screenToShow =
        (displayIndex == 1 || displayIndex == 2 || displayIndex == 3)
            ? _screens[0]
            : _screens[displayIndex];

    return Scaffold(
      key: scaffoldKey,
      drawer: _AppDrawer(
        currentIndex: _currentIndex,
        onNavigate: (index) {
          Navigator.pop(context); // close drawer
          setState(() => _currentIndex = index);
        },
        onPushScreen: (screen) {
          Navigator.pop(context); // close drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        onLogOut: () {
          Navigator.pop(context); // close drawer
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SplashScreen()),
            (route) => false,
          );
        },
      ),
      body: Stack(
        children: [
          screenToShow,
          const _ChatbotFAB(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
                _buildNavItem(
                    index: 1, icon: Icons.camera_alt_outlined, label: 'Camera'),
                _buildCenterButton(),
                _buildNavItem(
                    index: 3,
                    icon: Icons.language_rounded,
                    label: 'Live View'),
                _buildNavItem(
                    index: 4,
                    icon: Icons.people_outline_rounded,
                    label: 'Community'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    final color =
        isSelected ? Color(0xFF2979FF) : Color(0xFF9E9E9E);

    return GestureDetector(
      onTap: () => _onNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => _onNavTap(2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2979FF), Color(0xFF448AFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF2979FF).withValues(alpha: 0.35),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// App Drawer (Hamburger Sidebar)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _AppDrawer extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onNavigate;
  final ValueChanged<Widget> onPushScreen;
  final VoidCallback onLogOut;

  const _AppDrawer({
    required this.currentIndex,
    required this.onNavigate,
    required this.onPushScreen,
    required this.onLogOut,
  });

  @override
  State<_AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<_AppDrawer> {
  bool _darkMode = false;
  String? _activeLabel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.78,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8),
            // ── App Logo & Name ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color(0xFFE8EDF5), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // App logo
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                              Icons.architecture,
                              color: Color(0xFF2979FF),
                              size: 28),
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Text(
                      'UrbanLens',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // ── Main nav items ──
            _buildDrawerItem(
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              isActive: _activeLabel == 'Dashboard',
              onTap: () {
                setState(() => _activeLabel = 'Dashboard');
                widget.onNavigate(0);
              },
            ),
            _buildDrawerItem(
              icon: Icons.explore_rounded,
              label: 'Explore',
              isActive: _activeLabel == 'Explore',
              onTap: () {
                setState(() => _activeLabel = 'Explore');
                widget.onPushScreen(ExploreScreen());
              },
            ),
            _buildDrawerItem(
              icon: Icons.bookmark_rounded,
              label: 'Saved Projects',
              isActive: _activeLabel == 'Saved Projects',
              onTap: () {
                setState(() => _activeLabel = 'Saved Projects');
                widget.onPushScreen(ProjectsScreen());
              },
            ),

            // ── Divider ──
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Divider(color: Colors.grey.shade200, thickness: 1),
            ),

            // ── Secondary items ──
            _buildDrawerItem(
              icon: Icons.help_outline_rounded,
              label: 'Help & Support',
              isActive: _activeLabel == 'Help & Support',
              onTap: () {
                setState(() => _activeLabel = 'Help & Support');
                widget.onPushScreen(HelpScreen());
              },
            ),
            _buildDrawerItem(
              icon: Icons.nightlight_round,
              label: 'Dark Mode',
              isActive: _activeLabel == 'Dark Mode',
              trailing: ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemeManager.themeNotifier,
                builder: (context, mode, _) {
                  final isDark = mode == ThemeMode.dark;
                  return Switch(
                    value: isDark,
                    onChanged: (v) => ThemeManager.toggleTheme(v),
                    activeColor: const Color(0xFF2979FF),
                  );
                },
              ),
              onTap: () {
                setState(() => _activeLabel = 'Dark Mode');
                ThemeManager.toggleTheme(!ThemeManager.isDark);
              },
            ),
            _buildDrawerItem(
              icon: Icons.new_releases_rounded,
              label: "What's New",
              isActive: _activeLabel == "What's New",
              trailing: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFF2979FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() => _activeLabel = "What's New");
                widget.onPushScreen(WhatsNewScreen());
              },
            ),

            Spacer(),

            // ── Log Out ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: widget.onLogOut,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded,
                          color: Colors.redAccent, size: 22),
                      SizedBox(width: 16),
                      Text(
                        'Log Out',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ── Footer ──
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                '© 2026 Lemonferry Limited',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isActive
                ? Color(0xFF2979FF).withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive
                    ? Color(0xFF2979FF)
                    : Color(0xFF6B7280),
                size: 22,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? Color(0xFF2979FF)
                        : Color(0xFF1A1A2E),
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Create New Project Bottom Sheet
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _CreateProjectSheet extends StatelessWidget {
  const _CreateProjectSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xFFD0D0D0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Create New Project',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 24),
          _buildOption(
            context: context,
            icon: Icons.architecture_rounded,
            iconColor: Colors.white,
            bgColor: Color(0xFFFF8C00),
            title: 'New Design Project',
            subtitle: 'Start a new architectural design',
          ),
          SizedBox(height: 12),
          _buildOption(
            context: context,
            icon: Icons.camera_alt_rounded,
            iconColor: Colors.white,
            bgColor: Color(0xFF3A3A3A),
            title: 'Scan Site',
            subtitle: 'Capture and analyze a construction site',
          ),
          SizedBox(height: 12),
          _buildOption(
            context: context,
            icon: Icons.upload_file_rounded,
            iconColor: Colors.white,
            bgColor: Color(0xFF2979FF),
            title: 'Import Blueprint',
            subtitle: 'Upload existing plans and blueprints',
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xFFF5F8FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFE8EDF5), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A2E))),
                  SizedBox(height: 2),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF), size: 24),
          ],
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Chatbot FAB + Chat Overlay
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _ChatbotFAB extends StatefulWidget {
  const _ChatbotFAB();

  @override
  State<_ChatbotFAB> createState() => _ChatbotFABState();
}

class _ChatbotFABState extends State<_ChatbotFAB>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _isListening = false;
  final TextEditingController _msgController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Hi! I\'m DIMI. How can I help you today?',
      isBot: true,
      time: '12:00 PM',
    ),
    _ChatMessage(
      text: 'I can help with projects, AR features, site analysis, and more.',
      isBot: true,
      time: '12:00 PM',
    ),
  ];
  final ScrollController _scrollController = ScrollController();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isBot: false, time: _timeNow()));
      _msgController.clear();
    });
    _scrollToBottom();

    // Simulate bot reply
    Future.delayed(Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _messages.add(_ChatMessage(
            text: _getBotReply(text),
            isBot: true,
            time: _timeNow(),
          ));
        });
        _scrollToBottom();
      }
    });
  }

  String _getBotReply(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('project')) {
      return 'You can create a new project using the + button in the nav bar. Would you like me to guide you through the setup?';
    } else if (lower.contains('ar') || lower.contains('camera')) {
      return 'The AR Camera lets you visualize architectural designs in real space. Tap the Camera tab to get started!';
    } else if (lower.contains('help')) {
      return 'I\'m here to help! You can ask about projects, AR features, site scanning, or anything else.';
    } else if (lower.contains('hello') || lower.contains('hi')) {
      return 'Hello! 👋 What would you like to work on today?';
    }
    return 'That\'s interesting! I can assist with architectural projects, AR visualization, and site analysis. What would you like to explore?';
  }

  String _timeNow() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final ap = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ap';
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Chat overlay
        if (_isOpen) _buildChatOverlay(),

        // FAB button
        Positioned(
          bottom: 85,
          right: 16,
          child: AnimatedBuilder(
            animation: _pulseAnim,
            builder: (context, child) {
              return Transform.scale(
                scale: _isOpen ? 1.0 : _pulseAnim.value,
                child: GestureDetector(
                  onTap: () => setState(() => _isOpen = !_isOpen),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF007FFF), Color(0xFF3399FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF007FFF).withValues(alpha: 0.4),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isOpen ? Icons.close_rounded : Icons.chat_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatOverlay() {
    return Positioned(
      bottom: 150,
      right: 16,
      child: Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.black26,
        child: Container(
          width: 340,
          height: 440,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2979FF), Color(0xFF448AFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.smart_toy_rounded,
                          color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DIMI',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text('Online',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11, color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isOpen = false),
                      child: Icon(Icons.close_rounded,
                          color: Colors.white70, size: 22),
                    ),
                  ],
                ),
              ),

              // Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, i) =>
                      _buildMessageBubble(_messages[i]),
                ),
              ),

              // Input bar
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    // Voice input
                    GestureDetector(
                      onTap: () {
                        setState(() => _isListening = !_isListening);
                        if (_isListening) {
                          Future.delayed(
                              Duration(seconds: 2), () {
                            if (mounted) {
                              setState(() => _isListening = false);
                              _sendMessage('Show my active projects');
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: _isListening
                              ? Colors.redAccent.withValues(alpha: 0.1)
                              : Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _isListening
                              ? Icons.mic_rounded
                              : Icons.mic_none_rounded,
                          color: _isListening
                              ? Colors.redAccent
                              : Color(0xFF2979FF),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Text input
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color(0xFFE0E0E0)),
                        ),
                        child: TextField(
                          controller: _msgController,
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: _isListening
                                ? 'Listening...'
                                : 'Type a message...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Color(0xFF9CA3AF)),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                          ),
                          onSubmitted: _sendMessage,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Send button
                    GestureDetector(
                      onTap: () => _sendMessage(_msgController.text),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF2979FF),
                              Color(0xFF448AFF)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.send_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg) {
    return Align(
      alignment: msg.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: msg.isBot
              ? Color(0xFFF0F4FF)
              : Color(0xFF2979FF),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                msg.isBot ? Radius.zero : const Radius.circular(16),
            bottomRight:
                msg.isBot ? const Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: msg.isBot
                    ? Color(0xFF1A1A2E)
                    : Colors.white,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4),
            Text(
              msg.time,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: msg.isBot
                    ? Color(0xFF9CA3AF)
                    : Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;
  final String time;

  const _ChatMessage({
    required this.text,
    required this.isBot,
    required this.time,
  });
}
