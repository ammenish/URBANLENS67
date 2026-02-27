import 'package:flutter/material.dart';
import 'package:urban_lens/theme.dart';
import 'package:urban_lens/screens/help_screen.dart';
import 'package:urban_lens/screens/role_selection_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: UrbanTheme.primaryBlue,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(),
              SizedBox(height: 16),
              Text(
                'Alex Stratton',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: UrbanTheme.primaryBlue,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: UrbanTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'LEVEL 8',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: UrbanTheme.primaryYellow,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Senior Urban Designer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'alex.stratton@urbanlens.io',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: 24),
              _buildStatsBar(),
              SizedBox(height: 32),
              _buildSectionHeader('ACCOUNT WORKSPACE'),
              SizedBox(height: 16),
              _buildSettingsList([
                _buildSettingsTile(
                  context: context,
                  icon: Icons.person,
                  title: 'Personal Information',
                  subtitle: 'Bio, contact, and professional role',
                  page: const _PersonalInfoPage(),
                ),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.security,
                  title: 'Account Security',
                  subtitle: 'Password, 2FA, and sessions',
                  page: const _AccountSecurityPage(),
                ),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.notifications,
                  title: 'Notification Preferences',
                  subtitle: 'Project updates and community alerts',
                  isLast: true,
                  page: const _NotificationPrefsPage(),
                ),
              ]),
              SizedBox(height: 24),
              _buildSectionHeader('EXPERIENCE SETTINGS'),
              SizedBox(height: 16),
              _buildSettingsList([
                _buildSettingsTile(
                  context: context,
                  icon: Icons.view_in_ar,
                  title: 'AR Display Settings',
                  subtitle: 'Lidar accuracy and mesh rendering',
                  page: const _ARDisplayPage(),
                ),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.map,
                  title: 'Offline Maps',
                  subtitle: 'Manage 3D city data storage',
                  trailingBadge: 'PRO',
                  isLast: true,
                  page: const _OfflineMapsPage(),
                ),
              ]),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                },
                icon: Icon(Icons.support_agent, color: Colors.white),
                label: Text(
                  'Premium Support',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UrbanTheme.primaryBlue,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: UrbanTheme.primaryYellow, width: 3),
            color: Colors.grey.shade200,
          ),
          child: Icon(Icons.person, size: 50, color: Colors.grey),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: UrbanTheme.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit, size: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: UrbanTheme.primaryBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('142', 'PROJECTS'),
          Container(height: 30, width: 1, color: Colors.white24),
          _buildStatItem('2.4k', 'VOTES'),
          Container(height: 30, width: 1, color: Colors.white24),
          _buildStatItem('12', 'AWARDS'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UrbanTheme.primaryYellow,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white70,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade400,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSettingsList(List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: UrbanTheme.backgroundLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: tiles,
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
    String? trailingBadge,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: UrbanTheme.primaryBlue, size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: UrbanTheme.primaryBlue,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          trailing: trailingBadge != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: UrbanTheme.primaryYellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        trailingBadge,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: Colors.grey.shade400),
                  ],
                )
              : Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 72,
            endIndent: 20,
            color: Colors.grey.shade300,
          ),
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Sub-pages for each settings tile
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _PersonalInfoPage extends StatefulWidget {
  const _PersonalInfoPage();
  @override
  State<_PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<_PersonalInfoPage> {
  final _nameCtrl = TextEditingController(text: 'Alex Stratton');
  final _emailCtrl = TextEditingController(text: 'alex.stratton@urbanlens.io');
  final _bioCtrl = TextEditingController(text: 'Senior Urban Designer specializing in sustainable architecture and AR-integrated city planning.');
  final _phoneCtrl = TextEditingController(text: '+1 (555) 234-5678');
  String _role = 'Architect';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Personal Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryBlue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: UrbanTheme.primaryYellow,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            _label('Full Name'),
            _textField(_nameCtrl),
            SizedBox(height: 20),
            _label('Email Address'),
            _textField(_emailCtrl),
            SizedBox(height: 20),
            _label('Phone Number'),
            _textField(_phoneCtrl),
            SizedBox(height: 20),
            _label('Professional Role'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: UrbanTheme.backgroundLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _role,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: ['Architect', 'Urban Planner', 'Civil Engineer', 'Interior Designer', 'Student']
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setState(() => _role = v!),
                ),
              ),
            ),
            SizedBox(height: 20),
            _label('Bio'),
            Container(
              decoration: BoxDecoration(
                color: UrbanTheme.backgroundLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _bioCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Color(0xFF007FFF)),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: UrbanTheme.primaryYellow,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
      );

  Widget _textField(TextEditingController ctrl) => Container(
        decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(14)),
        child: TextField(
          controller: ctrl,
          decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
        ),
      );
}

// ── Account Security ──
class _AccountSecurityPage extends StatefulWidget {
  const _AccountSecurityPage();
  @override
  State<_AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<_AccountSecurityPage> {
  bool _twoFA = true;
  bool _biometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Account Security',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryBlue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Password'),
            _settingsCard([
              ListTile(
                leading: Icon(Icons.lock_outline, color: UrbanTheme.primaryYellow),
                title: Text('Change Password', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Last changed 30 days ago', style: TextStyle(fontSize: 12)),
                trailing: Icon(Icons.chevron_right),
                onTap: () => _showPasswordDialog(context),
              ),
            ]),
            SizedBox(height: 24),
            _sectionTitle('Two-Factor Authentication'),
            _settingsCard([
              SwitchListTile(
                title: Text('Enable 2FA', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Add extra security with SMS verification'),
                value: _twoFA,
                activeColor: UrbanTheme.primaryYellow,
                onChanged: (v) => setState(() => _twoFA = v),
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(
                title: Text('Biometric Login', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Use fingerprint or face ID'),
                value: _biometric,
                activeColor: UrbanTheme.primaryYellow,
                onChanged: (v) => setState(() => _biometric = v),
              ),
            ]),
            SizedBox(height: 24),
            _sectionTitle('Active Sessions'),
            _settingsCard([
              ListTile(
                leading: Icon(Icons.phone_android, color: UrbanTheme.primaryYellow),
                title: Text('Chrome — Windows', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Active now', style: TextStyle(fontSize: 12, color: Colors.green)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text('Current', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
                ),
              ),
              Divider(height: 1, indent: 16, endIndent: 16),
              ListTile(
                leading: Icon(Icons.tablet_mac, color: Colors.grey.shade400),
                title: Text('Safari — iPad', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('Last active 2 days ago', style: TextStyle(fontSize: 12)),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text('Revoke', style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'Current Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 12),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'New Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 12),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated!'), backgroundColor: Color(0xFF007FFF)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: UrbanTheme.primaryYellow, foregroundColor: Colors.white),
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(t, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1.0)),
      );

  Widget _settingsCard(List<Widget> children) => Container(
        decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(16)),
        child: Column(children: children),
      );
}

// ── Notification Preferences ──
class _NotificationPrefsPage extends StatefulWidget {
  const _NotificationPrefsPage();
  @override
  State<_NotificationPrefsPage> createState() => _NotificationPrefsPageState();
}

class _NotificationPrefsPageState extends State<_NotificationPrefsPage> {
  bool _projectUpdates = true;
  bool _communityAlerts = true;
  bool _arNotifs = false;
  bool _emailDigest = true;
  bool _pushNotifs = true;
  bool _sounds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notification Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryBlue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('PROJECT NOTIFICATIONS'),
            _card([
              _toggle('Project Updates', 'Get notified when projects are modified', _projectUpdates, (v) => setState(() => _projectUpdates = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              _toggle('Community Alerts', 'New comments, likes, and shares', _communityAlerts, (v) => setState(() => _communityAlerts = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              _toggle('AR Session Alerts', 'Notifications during AR sessions', _arNotifs, (v) => setState(() => _arNotifs = v)),
            ]),
            SizedBox(height: 24),
            _sectionTitle('DELIVERY METHOD'),
            _card([
              _toggle('Email Digest', 'Daily summary of activities', _emailDigest, (v) => setState(() => _emailDigest = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              _toggle('Push Notifications', 'Real-time alerts on device', _pushNotifs, (v) => setState(() => _pushNotifs = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              _toggle('Notification Sounds', 'Play sounds for alerts', _sounds, (v) => setState(() => _sounds = v)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _toggle(String title, String sub, bool val, ValueChanged<bool> onChanged) => SwitchListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(sub, style: TextStyle(fontSize: 12)),
        value: val,
        activeColor: UrbanTheme.primaryYellow,
        onChanged: onChanged,
      );

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(t, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1.0)),
      );

  Widget _card(List<Widget> ch) => Container(
        decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(16)),
        child: Column(children: ch),
      );
}

// ── AR Display Settings ──
class _ARDisplayPage extends StatefulWidget {
  const _ARDisplayPage();
  @override
  State<_ARDisplayPage> createState() => _ARDisplayPageState();
}

class _ARDisplayPageState extends State<_ARDisplayPage> {
  double _lidarAccuracy = 0.75;
  double _meshQuality = 0.6;
  bool _showGrid = true;
  bool _showMeasurements = true;
  bool _showLabels = false;
  String _renderMode = 'Realistic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('AR Display Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryBlue)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('RENDERING'),
            _card([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lidar Accuracy', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('${(_lidarAccuracy * 100).round()}%', style: TextStyle(color: UrbanTheme.primaryYellow, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Slider(value: _lidarAccuracy, activeColor: UrbanTheme.primaryYellow, onChanged: (v) => setState(() => _lidarAccuracy = v)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mesh Quality', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('${(_meshQuality * 100).round()}%', style: TextStyle(color: UrbanTheme.primaryYellow, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Slider(value: _meshQuality, activeColor: UrbanTheme.primaryYellow, onChanged: (v) => setState(() => _meshQuality = v)),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 24),
            _sectionTitle('RENDER MODE'),
            _card([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: ['Realistic', 'Wireframe', 'X-Ray'].map((mode) {
                    final selected = _renderMode == mode;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _renderMode = mode),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? UrbanTheme.primaryYellow : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(mode, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: selected ? Colors.white : UrbanTheme.primaryBlue)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
            SizedBox(height: 24),
            _sectionTitle('OVERLAYS'),
            _card([
              SwitchListTile(title: Text('Show Grid', style: TextStyle(fontWeight: FontWeight.w600)), value: _showGrid, activeColor: UrbanTheme.primaryYellow, onChanged: (v) => setState(() => _showGrid = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(title: Text('Show Measurements', style: TextStyle(fontWeight: FontWeight.w600)), value: _showMeasurements, activeColor: UrbanTheme.primaryYellow, onChanged: (v) => setState(() => _showMeasurements = v)),
              Divider(height: 1, indent: 16, endIndent: 16),
              SwitchListTile(title: Text('Show Labels', style: TextStyle(fontWeight: FontWeight.w600)), value: _showLabels, activeColor: UrbanTheme.primaryYellow, onChanged: (v) => setState(() => _showLabels = v)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(t, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1.0)),
      );

  Widget _card(List<Widget> ch) => Container(
        decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(16)),
        child: Column(children: ch),
      );
}

// ── Offline Maps ──
class _OfflineMapsPage extends StatelessWidget {
  const _OfflineMapsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: UrbanTheme.primaryBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Offline Maps',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryBlue)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: UrbanTheme.primaryYellow, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text('PRO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Icon(Icons.storage, color: UrbanTheme.primaryYellow, size: 32),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Storage Used', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('2.4 GB / 10 GB', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                  Spacer(),
                  Text('24%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: UrbanTheme.primaryYellow)),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text('DOWNLOADED MAPS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1.0)),
            SizedBox(height: 12),
            _mapItem('New York City', '1.2 GB', '3D Buildings + Streets'),
            _mapItem('San Francisco', '800 MB', 'Streets only'),
            _mapItem('London', '400 MB', 'Landmarks + Streets'),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download, color: Colors.white),
              label: Text('Download New Map', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: UrbanTheme.primaryYellow,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapItem(String name, String size, String desc) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: UrbanTheme.backgroundLight, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Icon(Icons.map, color: UrbanTheme.primaryYellow),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                ],
              ),
            ),
            Text(size, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
            SizedBox(width: 8),
            Icon(Icons.delete_outline, color: Colors.red.shade300, size: 20),
          ],
        ),
      );
}
