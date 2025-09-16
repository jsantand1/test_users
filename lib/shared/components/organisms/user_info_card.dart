import 'package:flutter/material.dart';
import '../atoms/custom_card.dart';
import '../molecules/info_row.dart';
import '../../models/user_info_data.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfoData data;
  final VoidCallback? onEdit;

  const UserInfoCard({
    super.key,
    required this.data,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  data.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.fullName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (onEdit != null)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ...data.infoRows.map((rowData) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InfoRow(
              label: rowData.label,
              value: rowData.value,
            ),
          )),
        ],
      ),
    );
  }
}
