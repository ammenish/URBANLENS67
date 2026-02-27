import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: UrbanTheme.primaryYellow,
                    child: Icon(Icons.support_agent, color: UrbanTheme.primaryBlue, size: 18),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Urban Lens',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: UrbanTheme.primaryBlue,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.notifications, color: UrbanTheme.primaryBlue, size: 20),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'How can we help?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: UrbanTheme.primaryBlue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Search our knowledge base or contact us.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 24),
              _buildSearchBar(),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: UrbanTheme.primaryBlue,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: UrbanTheme.primaryYellow,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildCategoryTile(
                icon: Icons.rocket_launch,
                title: 'Getting Started',
                subtitle: 'Setup, onboarding, and basics',
              ),
              SizedBox(height: 12),
              _buildCategoryTile(
                icon: Icons.payments,
                title: 'Account & Billing',
                subtitle: 'Manage plans and subscriptions',
              ),
              SizedBox(height: 12),
              _buildCategoryTile(
                icon: Icons.view_in_ar,
                title: 'AR Troubleshooting',
                subtitle: 'Camera, tracking, and rendering',
              ),
              SizedBox(height: 32),
              Text(
                'Still need help?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UrbanTheme.primaryBlue,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.chat_bubble, size: 18),
                      label: Text('Live Chat', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UrbanTheme.primaryYellow,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.email, size: 18),
                      label: Text('Email Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UrbanTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: UrbanTheme.backgroundLight,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
          hintText: 'Search FAQs, guides, and more...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategoryTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: UrbanTheme.primaryYellow, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: UrbanTheme.primaryBlue,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
        ],
      ),
    );
  }
}
