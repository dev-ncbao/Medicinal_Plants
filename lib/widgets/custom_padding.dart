import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  const PagePadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 0, vertical: 20),
      child: child,
    );
  }
}

class WidgetPadding extends StatelessWidget {
  const WidgetPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 0),
      child: child,
    );
  }
}
