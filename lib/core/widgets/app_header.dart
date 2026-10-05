import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBack,
    this.actions,
  });

  final String? title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isBrand = title == null && !showBackButton;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton ? BackButton(onPressed: onBack) : null,
      title: isBrand
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.directions_bike,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text('Pedali'),
              ],
            )
          : title == null
          ? null
          : Text(title!),
      actions: actions,
    );
  }
}
