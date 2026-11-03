import 'package:flutter/material.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda & Catatan Saya'),
      ),
      body: const Center(
        child: Text('Daftar CRUD Database Supabase (Segera dihubungkan)'),
      ),
    );
  }
}