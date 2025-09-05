import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/team_controller.dart';
import 'pages/main_page.dart';
import 'services/api_service.dart';
import 'theme/app_theme.dart'; // ← ใช้ธีมใหม่

void main() {
  // ลงทะเบียน dependency ที่นี่ที่เดียว
  Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
  Get.put(TeamController()); // ใส่ครั้งเดียวที่ main

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokémon Team Builder',
      debugShowCheckedModeBanner: false,

      // ← ธีมใหม่ (Light/Dark) ด้วย Material 3
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,

      // หน้าแรกของแอป
      home: MainPage(), // ไม่ต้องใส่ const เพราะมี GetX controller ภายใน
    );
  }
}
