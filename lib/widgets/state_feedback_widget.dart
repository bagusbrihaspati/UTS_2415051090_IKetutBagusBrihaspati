import 'package:flutter/material.dart';

class StateFeedbackWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final String emptyMessage;
  final VoidCallback? onRetry;
  final Widget child;

  const StateFeedbackWidget({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.emptyMessage,
    this.onRetry,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat data kegiatan...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 54, color: Colors.redAccent),
              const SizedBox(height: 12),
              Text(
                'Terjadi Kesalahan',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              if (onRetry != null)
                FilledButton.tonalIcon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                ),
            ],
          ),
        ),
      );
    }

    return child;
  }
}