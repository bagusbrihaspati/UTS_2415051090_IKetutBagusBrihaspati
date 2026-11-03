import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengembang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 46,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'I Ketut Bagus Brihaspati',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('NIM: 2415051090', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Program Studi'),
              subtitle: const Text('Pendidikan Teknik Informatika (PTI 5A)'),
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Fakultas & Universitas'),
              subtitle: const Text('FTK - Universitas Pendidikan Ganesha'),
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Project UTS'),
              subtitle: const Text('EventHub - Campus Activity Manager'),
            ),
          ],
        ),
      ),
    );
  }
}