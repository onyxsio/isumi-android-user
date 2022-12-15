final String tableCart = 'cart';

class CartFields {
  static final List<String> values = [
    /// Add all fields
    id, name, quantity, price, color, size
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String quantity = 'quantity';
  static final String size = 'size';
  static final String color = 'color';
  static final String price = 'price';
}

class Cart {
  final String? id;
  final String size;
  final String quantity;
  final String name;
  final String color;
  final String price;

  const Cart({
    this.id,
    required this.size,
    required this.quantity,
    required this.name,
    required this.color,
    required this.price,
  });

  Cart copy({
    String? id,
    String? size,
    String? quantity,
    String? name,
    String? color,
    String? price,
  }) =>
      Cart(
        id: id ?? this.id,
        size: size ?? this.size,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        color: color ?? this.color,
        price: price ?? this.price,
      );

  static Cart fromJson(Map<String, Object?> json) => Cart(
        id: json[CartFields.id] as String?,
        size: json[CartFields.size] as String,
        quantity: json[CartFields.quantity] as String,
        name: json[CartFields.name] as String,
        color: json[CartFields.color] as String,
        price: json[CartFields.price] as String,
      );

  Map<String, Object?> toJson() => {
        CartFields.id: id,
        CartFields.name: name,
        CartFields.size: size,
        CartFields.quantity: quantity,
        CartFields.color: color,
        CartFields.price: price,
      };
}
