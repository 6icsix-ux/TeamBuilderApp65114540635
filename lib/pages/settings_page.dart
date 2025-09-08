import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _mode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    // ตั้งค่าเริ่มต้นแบบเดา ๆ จาก theme ปัจจุบัน
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _mode = ThemeMode.system;
    if (Get.isDarkMode) _mode = ThemeMode.dark;
    if (brightness == Brightness.light && !Get.isDarkMode) {
      _mode = ThemeMode.light;
    }
  }

  void _apply(ThemeMode mode) {
    setState(() => _mode = mode);
    Get.changeThemeMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16,16,16,8),
            child: Text('Appearance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: _mode,
            onChanged: (v) => _apply(v!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: _mode,
            onChanged: (v) => _apply(v!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: _mode,
            onChanged: (v) => _apply(v!),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(16,16,16,8),
            child: Text('Other', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
