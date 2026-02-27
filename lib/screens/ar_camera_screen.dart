import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';

class ArCameraScreen extends StatelessWidget {
  const ArCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1628),
      body: Stack(
        children: [
          // AR Viewfinder Background (simulated)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0E2A4A).withOpacity(0.9),
                  Color(0xFF1A3A5C).withOpacity(0.7),
                  Color(0xFF2A4A6C).withOpacity(0.5),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Grid lines
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: _GridPainter(),
          ),
          // Measurement overlay
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Height measurement
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: UrbanTheme.primaryYellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'H: 42.45m',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 100,
                  color: UrbanTheme.primaryYellow.withOpacity(0.7),
                ),
                // Width measurement
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 1,
                      color: UrbanTheme.primaryYellow.withOpacity(0.7),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: UrbanTheme.primaryYellow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'W: 12.01m',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 1,
                      color: UrbanTheme.primaryYellow.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close,
                        color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Urban Lens AR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildTopBarIcon(Icons.flash_on),
                  SizedBox(width: 8),
                  _buildTopBarIcon(Icons.settings),
                ],
              ),
            ),
          ),
          // Right Toolbar
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                _buildToolButton(Icons.layers, false),
                SizedBox(height: 12),
                _buildToolButton(Icons.straighten, false),
                SizedBox(height: 12),
                _buildToolButton(Icons.push_pin_outlined, false),
                SizedBox(height: 12),
                _buildToolButton(Icons.crop_rotate, false),
                SizedBox(height: 12),
                _buildToolButton(Icons.undo, false),
              ],
            ),
          ),
          // Left compass
          Positioned(
            left: 16,
            bottom: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
              child: Icon(Icons.explore, color: Colors.white70, size: 20),
            ),
          ),
          // Center Camera Button
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: UrbanTheme.primaryYellow.withOpacity(0.3),
                      width: 3),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera,
                        color: UrbanTheme.primaryYellow, size: 28),
                  ),
                ),
              ),
            ),
          ),
          // Mark Point Button
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  color: UrbanTheme.primaryYellow,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: UrbanTheme.primaryYellow.withOpacity(0.4),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_circle,
                        color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'MARK POINT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBarIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildToolButton(IconData icon, bool isActive) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isActive
            ? UrbanTheme.primaryYellow
            : Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? UrbanTheme.primaryYellow : Colors.white24,
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

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..strokeWidth = 0.5;

    // Vertical lines (perspective)
    const int vLines = 20;
    for (int i = 0; i <= vLines; i++) {
      final x = size.width * i / vLines;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    const int hLines = 30;
    for (int i = 0; i <= hLines; i++) {
      final y = size.height * i / hLines;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
