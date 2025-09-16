class Address {
  final String id;
  final String country;
  final String department;
  final String municipality;
  final String streetAddress;
  final String? additionalInfo;
  final bool isPrimary;

  const Address({
    required this.id,
    required this.country,
    required this.department,
    required this.municipality,
    required this.streetAddress,
    this.additionalInfo,
    this.isPrimary = false,
  });

  Address copyWith({
    String? id,
    String? country,
    String? department,
    String? municipality,
    String? streetAddress,
    Object? additionalInfo = const Object(),
    bool? isPrimary,
  }) {
    return Address(
      id: id ?? this.id,
      country: country ?? this.country,
      department: department ?? this.department,
      municipality: municipality ?? this.municipality,
      streetAddress: streetAddress ?? this.streetAddress,
      additionalInfo: additionalInfo == const Object() ? this.additionalInfo : additionalInfo as String?,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'department': department,
      'municipality': municipality,
      'streetAddress': streetAddress,
      'additionalInfo': additionalInfo,
      'isPrimary': isPrimary,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      country: json['country'] as String,
      department: json['department'] as String,
      municipality: json['municipality'] as String,
      streetAddress: json['streetAddress'] as String,
      additionalInfo: json['additionalInfo'] as String?,
      isPrimary: json['isPrimary'] as bool? ?? false,
    );
  }

  @override
  String toString() {
    return 'Address(id: $id, country: $country, department: $department, municipality: $municipality, streetAddress: $streetAddress, additionalInfo: $additionalInfo, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
