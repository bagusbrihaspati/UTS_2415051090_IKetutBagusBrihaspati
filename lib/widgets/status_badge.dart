import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    String label;

    switch (status.toLowerCase()) {
      case 'completed':
        bg = Colors.green.shade50;
        text = Colors.green.shade700;
        label = 'Selesai';
        break;
      case 'active':
        bg = Colors.blue.shade50;
        text = Colors.blue.shade700;
        label = 'Berjalan';
        break;
      default:
        bg = Colors.orange.shade50;
        text = Colors.orange.shade800;
        label = 'Rencana';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: text.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}