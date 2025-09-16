/// Modelo específico para el componente UserListItem
class UserListItemData {
  final String id;
  final String fullName;
  final String initials;
  final String birthDate;
  final int addressCount;
  final String editText;
  final String deleteText;

  const UserListItemData({
    required this.id,
    required this.fullName,
    required this.initials,
    required this.birthDate,
    required this.addressCount,
    required this.editText,
    required this.deleteText,
  });
}
