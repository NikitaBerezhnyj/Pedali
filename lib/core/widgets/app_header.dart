import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBack,
    this.action,
  });

  final String? title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Widget? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDefault = title == null && !showBackButton;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      title: isDefault
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.directions_bike),
                const SizedBox(width: 8),
                const Text('Pedali'),
              ],
            )
          : title == null
          ? null
          : Text(title!),
      actions: action == null ? null : [action!],
    );
  }
}
