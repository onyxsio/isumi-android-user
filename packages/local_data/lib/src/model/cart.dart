final String tableCart = 'cart';

class CartFields {
  static final List<String> values = [
    /// Add all fields
    id, name, quantity, price, color, size, pid, createdTime, currency
  ];

  static final String id = '_id';

  static final String name = 'name';
  static final String pid = 'pid';

  static final String quantity = 'quantity';
  static final String size = 'size';
  static final String color = 'color';
  static final String price = 'price';

  static final String image = 'image';

  static final String createdTime = 'createdTime';
  static final String currency = 'currency';
}

class Cart {
  final int? id;
  final String pid;
  final String size;
  final String quantity;
  final String name;
  final String color;
  final String price;
  final String image;
  final String currency;
  final DateTime createdTime;

  const Cart({
    this.id,
    required this.size,
    required this.quantity,
    required this.name,
    required this.color,
    required this.price,
    required this.pid,
    required this.image,
    required this.currency,
    required this.createdTime,
  });

  Cart copy({
    int? id,
    String? size,
    String? quantity,
    String? name,
    String? color,
    String? price,
    String? pid,
    String? image,
    DateTime? createdTime,
    String? currency,
  }) =>
      Cart(
        id: id ?? this.id,
        size: size ?? this.size,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        color: color ?? this.color,
        price: price ?? this.price,
        pid: pid ?? this.pid,
        image: image ?? this.image,
        currency: currency ?? this.currency,
        createdTime: createdTime ?? this.createdTime,
      );

  static Cart fromJson(Map<String, Object?> json) => Cart(
        id: json[CartFields.id] as int?,
        size: json[CartFields.size] as String,
        quantity: json[CartFields.quantity] as String,
        name: json[CartFields.name] as String,
        color: json[CartFields.color] as String,
        price: json[CartFields.price] as String,
        image: json[CartFields.image] as String,
        currency: json[CartFields.currency] as String,
        pid: json[CartFields.pid] as String,
        createdTime: DateTime.parse(json[CartFields.createdTime] as String),
      );

  Map<String, Object?> toJson() => {
        CartFields.id: id,
        CartFields.name: name,
        CartFields.size: size,
        CartFields.quantity: quantity,
        CartFields.color: color,
        CartFields.price: price,
        CartFields.image: image,
        CartFields.pid: pid,
        CartFields.currency: currency,
        CartFields.createdTime: createdTime.toIso8601String(),
      };
}
