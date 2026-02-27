import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: UrbanTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.arrow_back,
                          color: UrbanTheme.primaryBlue, size: 18),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: UrbanTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.architecture,
                        color: Colors.white, size: 22),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Projects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: UrbanTheme.primaryBlue,
                        ),
                      ),
                      Text(
                        'Good morning, Explorer',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: UrbanTheme.backgroundLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications_outlined,
                        color: UrbanTheme.primaryBlue, size: 20),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: UrbanTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search,
                        color: Colors.grey.shade400, size: 20),
                    hintText: 'Search your projects...',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: UrbanTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: UrbanTheme.primaryBlue,
                  unselectedLabelColor: UrbanTheme.textLight,
                  labelStyle: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'Active'),
                    Tab(text: 'Recent'),
                    Tab(text: 'Archived'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Featured Projects
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActiveTab(),
                  _buildActiveTab(), // Reuse for demo
                  _buildActiveTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: UrbanTheme.primaryBlue,
            ),
          ),
          SizedBox(height: 16),
          _buildProjectCard(
            title: 'Downtown Plaza Redevelopment',
            description:
                'Optimizing pedestrian flow in the central business district.',
            badgeText: 'IN PROGRESS',
            badgeColor: UrbanTheme.primaryYellow,
            editedTime: 'Edited 3h ago',
            teamCount: 3,
            bgColor: Color(0xFFE6F2FF),
            iconBg: Color(0xFF007FFF),
          ),
          SizedBox(height: 16),
          _buildProjectCard(
            title: 'Green Corridor Mapping',
            description:
                'AR overlay for existing botanical diversity in Sector 7.',
            badgeText: 'SCANNING',
            badgeColor: UrbanTheme.successGreen,
            editedTime: 'Edited 1d ago',
            teamCount: 2,
            bgColor: Color(0xFFF0F7FF),
            iconBg: Color(0xFF3399FF),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String description,
    required String badgeText,
    required Color badgeColor,
    required String editedTime,
    required int teamCount,
    required Color bgColor,
    required Color iconBg,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              color: iconBg.withOpacity(0.3),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.location_city,
                      size: 64, color: iconBg.withOpacity(0.5)),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: UrbanTheme.primaryBlue,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    // Team avatars
                    SizedBox(
                      width: 60 + (teamCount - 1) * 18.0,
                      height: 28,
                      child: Stack(
                        children: List.generate(
                          teamCount,
                          (i) => Positioned(
                            left: i * 18.0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: [
                                  Colors.blue.shade300,
                                  Colors.purple.shade300,
                                  Colors.teal.shade300,
                                ][i % 3],
                                border:
                                    Border.all(color: bgColor, width: 2),
                              ),
                              child: Icon(Icons.person,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      editedTime,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
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
