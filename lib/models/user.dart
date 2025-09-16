import 'address.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<Address> addresses;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.addresses = const [],
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
    );
  }

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();

  Address? get primaryAddress {
    try {
      return addresses.firstWhere((address) => address.isPrimary);
    } catch (e) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, birthDate: $birthDate, addresses: ${addresses.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
