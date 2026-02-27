import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedChip = 'Trending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: UrbanTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.grid_view,
                        color: UrbanTheme.primaryBlue, size: 18),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Urban Lens',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: UrbanTheme.primaryBlue,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: UrbanTheme.backgroundLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.notifications_outlined,
                        color: UrbanTheme.primaryBlue, size: 18),
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
                    hintText: 'Search community models...',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChip('Trending'),
                    SizedBox(width: 8),
                    _buildChip('Residential'),
                    SizedBox(width: 8),
                    _buildChip('Commercial'),
                    SizedBox(width: 8),
                    _buildChip('Landscape'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Model cards
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    _buildCommunityCard(
                      title: 'Modern Eco-Villa',
                      author: 'Elena Rodriguez',
                      description:
                          'High-detail 3D mesh with sustainable materials and solar panel integration for residential...',
                      rating: '4.9',
                      cardColor: Color(0xFFE8F5E9),
                      iconColor: Colors.green,
                    ),
                    SizedBox(height: 16),
                    _buildCommunityCard(
                      title: 'Urban Park Concept',
                      author: 'Marcus Chen',
                      description:
                          'Proposed redesign for the central plaza featuring modular seating and native flora.',
                      rating: '4.7',
                      cardColor: Color(0xFFF3E5F5),
                      iconColor: Colors.purple,
                    ),
                    SizedBox(height: 16),
                    _buildCommunityCard(
                      title: 'Minimalist\nWorkspace',
                      author: 'Sarah Jenkins',
                      description:
                          'A sleek office complex concept with floor-to-ceiling windows and open workspace layouts.',
                      rating: '4.8',
                      cardColor: Color(0xFFFFF3E0),
                      iconColor: Colors.orange,
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedChip == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedChip = label),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? UrbanTheme.primaryYellow : UrbanTheme.backgroundLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isSelected ? Colors.white : UrbanTheme.textLight,
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityCard({
    required String title,
    required String author,
    required String description,
    required String rating,
    required Color cardColor,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: UrbanTheme.borderGrey),
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
          // Image area
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Icon(Icons.location_city,
                      size: 64, color: iconColor.withOpacity(0.3)),
                ),
              ),
              // Rating badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star,
                          color: UrbanTheme.primaryYellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        rating,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: UrbanTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // View in AR badge
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: UrbanTheme.primaryYellow,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: UrbanTheme.primaryYellow.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.view_in_ar,
                          color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'View in AR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: UrbanTheme.primaryBlue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
