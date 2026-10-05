import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/widgets/empty_state.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    required this.errorTitle,
    required this.retryDescription,
    required this.retryLabel,
    this.onRetry,
    this.stateHeight,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  final VoidCallback? onRetry;
  final String errorTitle;
  final String retryDescription;
  final String retryLabel;

  final double? stateHeight;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => _frame(const CircularProgressIndicator()),
      error: (e, st) {
        debugPrint('AsyncValueView error: $e\n$st');

        return _frame(
          _ErrorState(
            title: errorTitle,
            description: retryDescription,
            retryLabel: retryLabel,
            onRetry: onRetry,
          ),
        );
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
  const _ErrorState({
    required this.title,
    required this.description,
    required this.retryLabel,
    this.onRetry,
  });

  final String title;
  final String description;
  final String retryLabel;
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
          description: description,
          iconColor: cs.onErrorContainer,
          iconBackgroundColor: cs.errorContainer,
        ),
        if (onRetry != null)
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(retryLabel),
          ),
      ],
    );
  }
}
