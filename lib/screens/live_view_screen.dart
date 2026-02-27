import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';

class LiveViewScreen extends StatelessWidget {
  const LiveViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UrbanTheme.darkNavy,
      body: Stack(
        children: [
          // Dark map background (simulated)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0A1628),
                  Color(0xFF112240),
                  Color(0xFF0D1B2A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Map grid overlay
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: _MapGridPainter(),
          ),
          // Map labels (simulated)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 20,
            child: Text(
              'Jersey City',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.3),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              'New York',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              'Times Square',
              style: TextStyle(
                fontSize: 9,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ),
          // Node markers
          Positioned(
            top: MediaQuery.of(context).size.height * 0.32,
            left: MediaQuery.of(context).size.width * 0.35,
            child: _buildNodeMarker('Node A-12'),
          ),
          // Pin markers
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: UrbanTheme.primaryYellow,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: UrbanTheme.primaryYellow.withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          // Top Header
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_back,
                              color: Colors.white, size: 18),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'PROJECT ALPHA',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: UrbanTheme.primaryYellow,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              'Site B - Sector 4',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: UrbanTheme.primaryYellow,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.pause,
                            color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
                // GPS accuracy
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: UrbanTheme.successGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.gps_fixed,
                          color: UrbanTheme.successGreen, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'GPS · 0.02m Accuracy',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: UrbanTheme.successGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Right Toolbar
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                _buildMapToolButton(Icons.layers, true),
                SizedBox(height: 12),
                _buildMapToolButton(Icons.push_pin, false),
                SizedBox(height: 12),
                _buildMapToolButton(Icons.edit, false),
                SizedBox(height: 12),
                _buildMapToolButton(Icons.search, false),
              ],
            ),
          ),
          // Bottom Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF0D1B2A),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(
                  top: BorderSide(
                      color: Colors.white.withOpacity(0.1), width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Targeting header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24)),
                    ),
                    child: Text(
                      'TARGETING: STEEL BEAM #402-A',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: UrbanTheme.primaryYellow,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // BIM thumbnail
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: UrbanTheme.mediumBlue,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Icon(Icons.view_in_ar,
                              color: UrbanTheme.primaryYellow, size: 28),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'BIM OBJECT DATA',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.4),
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: UrbanTheme.successGreen
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'VERIFIED',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: UrbanTheme.successGreen,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Beam #402-A',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Structural Steel • Level 4',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Progress bar and Inspect button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: 0.85,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          UrbanTheme.primaryYellow),
                                  minHeight: 4,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.check_circle,
                                      size: 12,
                                      color: UrbanTheme.successGreen),
                                  SizedBox(width: 4),
                                  Text(
                                    'Install 2 days ago',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '85%',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: UrbanTheme.primaryYellow,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: UrbanTheme.primaryYellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Inspect',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeMarker(String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildMapToolButton(IconData icon, bool isActive) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isActive
            ? UrbanTheme.primaryYellow
            : Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? UrbanTheme.primaryYellow
              : Colors.white.withOpacity(0.2),
        ),
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.white,
        size: 20,
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 0.5;

    // Road-like lines
    // Horizontal roads
    for (double y = 0; y < size.height; y += 60) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical roads
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Water area (subtle blue tint on left side)
    final waterPaint = Paint()
      ..color = Color(0xFF1A3A5C).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.3, size.width * 0.3, size.height * 0.4),
      waterPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
