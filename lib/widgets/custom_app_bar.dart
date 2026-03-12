import 'package:flutter/material.dart';

class StarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;

  const StarAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: showBack,
      actions: actions,
      centerTitle: true,
    );
  }
}

class SliverStarAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final double expandedHeight;
  final Widget? background;

  const SliverStarAppBar({
    super.key,
    required this.title,
    this.actions,
    this.expandedHeight = 200,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        background: background,
      ),
      actions: actions,
    );
  }
}
