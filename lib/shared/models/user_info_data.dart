import 'info_row_data.dart';

class UserInfoData {
  final String fullName;
  final String initials;
  final List<InfoRowData> infoRows;

  const UserInfoData({
    required this.fullName,
    required this.initials,
    required this.infoRows,
  });
}
