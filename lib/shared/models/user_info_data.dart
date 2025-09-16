import 'info_row_data.dart';

/// Modelo específico para el componente UserInfoCard
class UserInfoData {
  final String fullName;
  final String email;
  final String initials;
  final List<InfoRowData> infoRows;

  const UserInfoData({
    required this.fullName,
    required this.email,
    required this.initials,
    required this.infoRows,
  });
}
