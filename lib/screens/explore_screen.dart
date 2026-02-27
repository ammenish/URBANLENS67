import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';
import 'package:urban_lens/screens/whats_new_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedChip = 'Buildings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: UrbanTheme.primaryBlue,
              child: Icon(Icons.architecture, color: UrbanTheme.primaryYellow, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              'Explore',
              style: UrbanTheme.theme.textTheme.displayMedium?.copyWith(
                fontSize: 22,
                color: UrbanTheme.primaryBlue,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: UrbanTheme.primaryBlue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WhatsNewScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 16),
              _buildFilterChips(),
              SizedBox(height: 16),
              _buildModelCard(
                imageColor: Colors.blueGrey.shade100,
                rating: '4.9',
                title: 'Modern Skyscraper',
                author: 'by UrbanStudio',
              ),
              SizedBox(height: 16),
              _buildModelCard(
                imageColor: Colors.green.shade100,
                rating: '4.7',
                title: 'Modular Bench',
                author: 'by GreenCity Design',
              ),
              SizedBox(height: 16),
              _buildModelCard(
                imageColor: Colors.orange.shade100,
                rating: '4.8',
                title: 'Smart Bus Stop',
                author: 'by TransitLabs',
              ),
              SizedBox(height: 16),
              _buildModelCard(
                imageColor: Colors.deepPurple.shade100,
                rating: '5.0',
                title: 'Eco Pavilion',
                author: 'by WoodStructure',
              ),
              SizedBox(height: 100),
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
          hintText: 'Search 3D models',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('Buildings', Icons.domain),
          SizedBox(width: 8),
          _buildChip('Furniture', Icons.chair),
          SizedBox(width: 8),
          _buildChip('Parks', Icons.park),
          SizedBox(width: 8),
          _buildChip('Roads', Icons.add_road),
        ],
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : UrbanTheme.textLight,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isSelected ? Colors.white : UrbanTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModelCard({
    required Color imageColor,
    required String rating,
    required String title,
    required String author,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: imageColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 64, color: Colors.black12),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: UrbanTheme.primaryYellow, size: 14),
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UrbanTheme.primaryYellow,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.view_in_ar, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'View in AR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
