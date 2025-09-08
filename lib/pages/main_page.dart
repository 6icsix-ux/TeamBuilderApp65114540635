import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';
import '../widgets/pokemon_list.dart';
import 'team_preview_page.dart';
import 'about_page.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TeamController teamCtrl = Get.find<TeamController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openRenameDialog(BuildContext context) {
    _nameController.text = teamCtrl.teamName.value;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rename Team'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Enter team name'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              teamCtrl.renameTeam(_nameController.text.trim());
              Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _openPreview() => Get.to(() => TeamPreviewPage());

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(teamCtrl.teamName.value)),
        actions: [
          // ตัวนับทีมแบบ Chip
          Obx(
            () => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${teamCtrl.team.length}/3',
                    style: TextStyle(
                      color: cs.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Edit Team Name',
            icon: const Icon(Icons.edit),
            onPressed: () => _openRenameDialog(context),
          ),
          IconButton(
            tooltip: 'Reset Team',
            icon: const Icon(Icons.refresh),
            onPressed: teamCtrl.resetTeam,
          ),
          // ⬇️ เมนู 3 จุด: ไป Settings และ About
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                Get.to(() => const SettingsPage());
              } else if (value == 'about') {
                Get.to(() => const AboutPage());
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'settings', child: Text('Settings')),
              PopupMenuItem(value: 'about', child: Text('About')),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔎 ค้นหา
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  onChanged: teamCtrl.setQuery,
                  decoration: InputDecoration(
                    hintText: 'Search Pokémon…',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Obx(() {
                      final isEmpty = teamCtrl.query.isEmpty;
                      return isEmpty
                          ? const SizedBox.shrink()
                          : IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _searchCtrl.clear();
                                teamCtrl.setQuery('');
                              },
                            );
                    }),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(height: 8),
          // รายการโปเกมอน
          Expanded(child: PokemonList()),

        ],
      ),

      // ✅ ปุ่ม Preview
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openPreview,
        icon: const Icon(Icons.visibility_rounded),
        label: const Text('Preview'),
      ),
    );
  }
}
