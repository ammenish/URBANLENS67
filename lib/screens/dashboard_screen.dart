import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_lens/theme.dart';
import 'package:urban_lens/screens/profile_screen.dart';
import 'package:urban_lens/main_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    // Hamburger menu
                    GestureDetector(
                      onTap: () {
                        final mainState = context.findAncestorStateOfType<MainScreenState>();
                        mainState?.openDrawer();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: UrbanTheme.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.menu_rounded,
                            color: UrbanTheme.primaryBlue, size: 22),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Greeting text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Alex',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: UrbanTheme.primaryBlue,
                          ),
                        ),
                        Text(
                          'Ready to build today?',
                          style: TextStyle(
                            fontSize: 13,
                            color: UrbanTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    _buildNotificationBell(context),
                    SizedBox(width: 8),
                    // Profile avatar — navigates to Profile Settings
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen()),
                        );
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: UrbanTheme.primaryYellow,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(Icons.person,
                            color: Colors.white, size: 26),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28),
                // Performance Overview
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: UrbanTheme.backgroundLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PERFORMANCE OVERVIEW',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.folder_open,
                              iconColor: UrbanTheme.primaryYellow,
                              value: '24',
                              label: 'Active Projects',
                              change: '+12%',
                              changeColor: UrbanTheme.successGreen,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.view_in_ar,
                              iconColor: UrbanTheme.primaryYellow,
                              value: '3.8k',
                              label: 'AR Interactions',
                              change: '+28%',
                              changeColor: UrbanTheme.successGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28),
                // Recent Projects Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Projects',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: UrbanTheme.primaryBlue,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: UrbanTheme.primaryYellow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Project Cards
                _buildProjectCard(
                  title: 'Mars Colony AR',
                  subtitle: 'Last modified 2h ago',
                  badgeText: 'AR LIVE',
                  badgeColor: UrbanTheme.successGreen,
                  gradientColors: [
                    Color(0xFF2D3436),
                    Color(0xFF3D3D3D)
                  ],
                  icon: Icons.public,
                ),
                SizedBox(height: 16),
                _buildProjectCard(
                  title: 'Cyberpunk Interior',
                  subtitle: 'Last modified 1d ago',
                  badgeText: 'DRAFTING',
                  badgeColor: UrbanTheme.primaryYellow,
                  gradientColors: [
                    Color(0xFFD6EAFF),
                    Color(0xFFE8F4FF)
                  ],
                  icon: Icons.location_city,
                  lightCard: true,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: UrbanTheme.primaryYellow,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: UrbanTheme.primaryYellow.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.add, color: UrbanTheme.primaryBlue, size: 28),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: UrbanTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: UrbanTheme.primaryBlue, size: 20),
    );
  }

  Widget _buildNotificationBell(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 8,
      icon: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: UrbanTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.notifications_outlined,
                color: UrbanTheme.primaryBlue, size: 20),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '4',
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Notifications',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E))),
                  Text('Mark all as read',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2979FF))),
                ],
              ),
              SizedBox(height: 4),
              Divider(),
            ],
          ),
        ),
        _notifItem(
          icon: Icons.architecture_rounded,
          iconBg: Color(0xFFFF8C00),
          title: 'New project approved',
          subtitle: 'Mars Colony AR is now live',
          time: '2 min ago',
          isUnread: true,
        ),
        _notifItem(
          icon: Icons.comment_rounded,
          iconBg: Color(0xFF2979FF),
          title: 'New comment',
          subtitle: 'Sarah left feedback on Interior',
          time: '15 min ago',
          isUnread: true,
        ),
        _notifItem(
          icon: Icons.people_rounded,
          iconBg: Color(0xFF4CAF50),
          title: 'Team invite accepted',
          subtitle: 'Mike joined your workspace',
          time: '1h ago',
          isUnread: false,
        ),
        _notifItem(
          icon: Icons.update_rounded,
          iconBg: Color(0xFF9C27B0),
          title: 'System update',
          subtitle: 'AR engine v2.4 available',
          time: '3h ago',
          isUnread: false,
        ),
      ],
    );
  }

  PopupMenuItem<String> _notifItem({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return PopupMenuItem<String>(
      value: title,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconBg, size: 18),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: isUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: Color(0xFF1A1A2E))),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFF2979FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Color(0xFF6B7280))),
                  SizedBox(height: 2),
                  Text(time,
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    required String change,
    required Color changeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: changeColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: UrbanTheme.primaryBlue,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required List<Color> gradientColors,
    required IconData icon,
    bool lightCard = false,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background icon
          Positioned(
            right: 20,
            top: 20,
            child: Icon(icon, size: 100, color: lightCard ? Color(0xFF007FFF).withOpacity(0.08) : Colors.white.withOpacity(0.1)),
          ),
          // Badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: lightCard ? Colors.white : Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: lightCard ? UrbanTheme.primaryBlue : Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: lightCard ? Colors.grey.shade500 : Colors.white70),
                    SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: lightCard ? Colors.grey.shade500 : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
