import 'package:flutter/material.dart';
import '../atoms/custom_card.dart';
import '../../models/empty_state_data.dart';

/// Molécula para mostrar estados vacíos
class EmptyState extends StatelessWidget {
  final EmptyStateData data;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.data,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconData(data.iconData),
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              data.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            if (data.actionText != null && onAction != null) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: onAction,
                child: Text(data.actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'location_off':
        return Icons.location_off;
      case 'person_off':
        return Icons.person_off;
      case 'inbox':
        return Icons.inbox;
      default:
        return Icons.info_outline;
    }
  }
}
