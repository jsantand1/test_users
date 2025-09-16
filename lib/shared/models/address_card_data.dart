class AddressCardData {
  final String streetAddress;
  final String location;
  final String country;
  final String? additionalInfo;
  final bool isPrimary;

  const AddressCardData({
    required this.streetAddress,
    required this.location,
    required this.country,
    this.additionalInfo,
    required this.isPrimary,
  });
}
