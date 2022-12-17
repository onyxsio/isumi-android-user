final String tableAddress = 'address';

class AddressFields {
  static final List<String> values = [
    /// Add all fields
    id, name, state, streetAddress, city, postalCode, isSelected, createdTime
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String state = 'state';
  static final String streetAddress = 'streetAddress';
  static final String city = 'city';
  static final String postalCode = 'postalCode';
  static final String isSelected = 'isSelected';
  static final String createdTime = 'createdTime';
}

class LAddress {
  final int? id;
  final String state;
  final String city;
  final String streetAddress;
  final String name;
  final String postalCode;
  final bool isSelected;
  final DateTime createdTime;

  const LAddress({
    this.id,
    required this.state,
    required this.city,
    required this.name,
    required this.streetAddress,
    required this.postalCode,
    required this.isSelected,
    required this.createdTime,
  });

  LAddress copy({
    int? id,
    String? state,
    String? city,
    String? name,
    String? streetAddress,
    bool? isSelected,
    String? postalCode,
    DateTime? createdTime,
  }) =>
      LAddress(
        id: id ?? this.id,
        state: state ?? this.state,
        city: city ?? this.city,
        name: name ?? this.name,
        streetAddress: streetAddress ?? this.streetAddress,
        isSelected: isSelected ?? this.isSelected,
        postalCode: postalCode ?? this.postalCode,
        createdTime: createdTime ?? this.createdTime,
      );

  static LAddress fromJson(Map<String, Object?> json) => LAddress(
        id: json[AddressFields.id] as int?,
        state: json[AddressFields.state] as String,
        city: json[AddressFields.city] as String,
        name: json[AddressFields.name] as String,
        streetAddress: json[AddressFields.streetAddress] as String,
        postalCode: json[AddressFields.postalCode] as String,
        isSelected: json[AddressFields.isSelected] == 1,
        createdTime: DateTime.parse(json[AddressFields.createdTime] as String),
      );

  Map<String, Object?> toJson() => {
        AddressFields.id: id,
        AddressFields.name: name,
        AddressFields.state: state,
        AddressFields.city: city,
        AddressFields.streetAddress: streetAddress,
        AddressFields.postalCode: postalCode,
        AddressFields.isSelected: isSelected ? 1 : 0,
        AddressFields.createdTime: createdTime.toIso8601String(),
      };
}
