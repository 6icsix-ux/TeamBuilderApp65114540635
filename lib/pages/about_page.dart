import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Pokémon Team Builder'),
            subtitle: Text('Sample app for building a small Pokémon team.'),
            leading: Icon(Icons.catching_pokemon),
          ),
          Divider(),
          ListTile(
            title: Text('Version'),
            subtitle: Text('1.0.0'),
            leading: Icon(Icons.info_outline),
          ),
          Divider(),
          ListTile(
            title: Text('Licenses'),
            subtitle: Text('View open-source licenses'),
            leading: Icon(Icons.description_outlined),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton.icon(
          onPressed: () => showLicensePage(
            context: context,
            applicationName: 'Pokémon Team Builder',
            applicationVersion: '1.0.0',
          ),
          icon: const Icon(Icons.article_outlined),
          label: const Text('Open Licenses'),
        ),
      ),
    );
  }
}
