import 'package:flutter/material.dart';
import '../config/theme_config.dart';

class StarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Widget? bottom;
  final double bottomHeight;

  const StarAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.bottom,
    this.bottomHeight = 0,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      bottom: bottom as PreferredSizeWidget?,
    );
  }
}

class SliverStarAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool pinned;
  final double expandedHeight;
  final Widget? flexibleContent;

  const SliverStarAppBar({
    super.key,
    required this.title,
    this.actions,
    this.pinned = true,
    this.expandedHeight = kToolbarHeight,
    this.flexibleContent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      actions: actions,
      pinned: pinned,
      expandedHeight: expandedHeight,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      flexibleSpace: flexibleContent != null
          ? FlexibleSpaceBar(background: flexibleContent)
          : null,
    );
  }
}
