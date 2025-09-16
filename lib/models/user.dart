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
  
  String get email => '${firstName.toLowerCase()}.${lastName.toLowerCase()}@example.com';
  
  String get phone => '+1234567890';
  
  String get initials => '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'.toUpperCase();

  Address? get primaryAddress {
    try {
      return addresses.firstWhere((address) => address.isPrimary);
    } catch (e) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String(),
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      birthDate:
          DateTime.tryParse(json['birthDate']?.toString() ?? '') ??
          DateTime(1970),
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map(
                (addressJson) =>
                    Address.fromJson(addressJson as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
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
