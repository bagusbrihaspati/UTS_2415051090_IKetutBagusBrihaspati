import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget compact;
  final Widget expanded;

  const ResponsiveLayout({
    super.key,
    required this.compact,
    required this.expanded,
  });

  static bool isCompact(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isExpanded(BuildContext context) =>
      MediaQuery.of(context).size.width >= 840;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 840) {
          return expanded;
        }
        return compact;
      },
    );
  }
}
