import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/widgets/empty_state.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
    this.errorTitle = 'Не вдалося завантажити дані',
    this.stateHeight,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  final VoidCallback? onRetry;
  final String errorTitle;

  final double? stateHeight;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => _frame(const CircularProgressIndicator()),
      error: (e, st) {
        debugPrint('AsyncValueView error: $e\n$st');
        return _frame(_ErrorState(title: errorTitle, onRetry: onRetry));
      },
      data: data,
    );
  }

  Widget _frame(Widget child) {
    final centered = Center(child: child);
    return stateHeight == null
        ? centered
        : SizedBox(height: stateHeight, child: centered);
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.title, this.onRetry});

  final String title;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EmptyState(
          icon: Icons.error_outline,
          title: title,
          description: 'Спробуй ще раз трохи пізніше.',
          iconColor: cs.onErrorContainer,
          iconBackgroundColor: cs.errorContainer,
        ),
        if (onRetry != null)
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Спробувати ще'),
          ),
      ],
    );
  }
}
