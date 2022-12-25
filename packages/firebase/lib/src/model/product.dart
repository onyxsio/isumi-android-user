// import 'package:onyxsio/onyxsio.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? sId;
  String? sellerId;
  String? title;
  String? qrCode;
  String? description;
  String? productCategory;
  String? productGroup;
  String? gender;
  String? brand;
  String? stock;
  String? thumbnail;
  Shipping? shipping;
  Price? price;
  Offers? offers;
  Rivews? rivews;
  List<Variant>? variant;
  Package? package;
  List? images;
  List? suggestion;
  List<Taxes>? taxes;
  // Promotion? promotion;

  Product({
    this.sId,
    this.title,
    this.description,
    this.productCategory,
    this.productGroup,
    this.gender,
    this.qrCode,
    this.brand,
    this.stock,
    this.thumbnail,
    this.shipping,
    this.price,
    this.offers,
    this.rivews,
    this.variant,
    this.package,
    this.images,
    this.suggestion,
    this.taxes,
    this.sellerId,
  });

  Product copyWith({
    String? sId,
    String? sellerId,
    String? title,
    String? description,
    String? qrCode,
    String? productCategory,
    String? productGroup,
    String? gender,
    String? brand,
    String? stock,
    String? thumbnail,
    Shipping? shipping,
    Price? price,
    Offers? offers,
    Rivews? rivews,
    List<Variant>? variant,
    Package? package,
    List? images,
    List? suggestion,
    List<Taxes>? taxes,
  }) {
    return Product(
      sId: sId ?? this.sId,
      sellerId: sellerId ?? this.sellerId,
      title: title ?? this.title,
      qrCode: qrCode ?? this.qrCode,
      description: description ?? this.description,
      productCategory: productCategory ?? this.productCategory,
      productGroup: productGroup ?? this.productGroup,
      gender: gender ?? this.gender,
      brand: brand ?? this.brand,
      stock: stock ?? this.stock,
      thumbnail: thumbnail ?? this.thumbnail,
      shipping: shipping ?? this.shipping,
      price: price ?? this.price,
      offers: offers ?? this.offers,
      rivews: rivews ?? this.rivews,
      variant: variant ?? this.variant,
      package: package ?? this.package,
      images: images ?? this.images,
      suggestion: suggestion ?? this.suggestion,
      taxes: taxes ?? this.taxes,
    );
  }

  // !
  Product.fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
    sId = json['_id'];
    sellerId = json['sellerId'];
    title = json['title'];
    qrCode = json['qrCode'];
    description = json['description'];
    productCategory = json['productCategory'];
    productGroup = json['productGroup'];
    gender = json['gender'];
    brand = json['brand'];
    stock = json['stock'];
    thumbnail = json['thumbnail'];
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    offers = json['offers'] != null ? Offers.fromJson(json['offers']) : null;
    rivews = json['rivews'] != null ? Rivews.fromJson(json['rivews']) : null;
    // if (json['rivews'] != null) {
    //   rivews = <Rivews>[];
    //   json['rivews'].forEach((v) {
    //     rivews!.add(Rivews.fromJson(v));
    //   });
    // }
    if (json['variant'] != null) {
      variant = <Variant>[];
      json['variant'].forEach((v) {
        variant!.add(Variant.fromJson(v));
      });
    }

    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    // images = json['images'].cast<String>();
    // suggestion = json['suggestion'].cast<String>();
    images = json['images'];
    suggestion = json['suggestion'];
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(Taxes.fromJson(v));
      });
    }
    // promotion = json['promotion'] != null
    //     ? Promotion.fromJson(json['promotion'])
    //     : null;
  }
//
  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    qrCode = json['qrCode'];
    sellerId = json['sellerId'];
    description = json['description'];
    productCategory = json['productCategory'];
    productGroup = json['productGroup'];
    gender = json['gender'];
    brand = json['brand'];
    stock = json['stock'];
    thumbnail = json['thumbnail'];
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    offers = json['offers'] != null ? Offers.fromJson(json['offers']) : null;

    rivews = json['rivews'] != null ? Rivews.fromJson(json['rivews']) : null;
    // if (json['rivews'] != null) {
    //   rivews = <Rivews>[];
    //   json['rivews'].forEach((v) {
    //     rivews!.add(Rivews.fromJson(v));
    //   });
    // }
    if (json['variant'] != null) {
      variant = <Variant>[];
      json['variant'].forEach((v) {
        variant!.add(Variant.fromJson(v));
      });
    }

    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    images = json['images'].cast<String>();
    suggestion = json['suggestion'].cast<String>();
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(Taxes.fromJson(v));
      });
    }
    // promotion = json['promotion'] != null
    //     ? Promotion.fromJson(json['promotion'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['sellerId'] = sellerId;
    data['qrCode'] = qrCode;
    data['description'] = description;
    data['productCategory'] = productCategory;
    data['productGroup'] = productGroup;
    data['gender'] = gender;
    data['brand'] = brand;
    data['stock'] = stock;
    data['thumbnail'] = thumbnail;
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (offers != null) {
      data['offers'] = offers!.toJson();
    }
    if (rivews != null) {
      data['rivews'] = rivews!.toJson();
      // data['rivews'] = rivews!.map((v) => v.toJson()).toList();
    }
    if (variant != null) {
      // data['variant'] = variant!.toJson();
      data['variant'] = variant!.map((v) => v.toJson()).toList();
    }
    if (package != null) {
      data['package'] = package!.toJson();
    }
    data['images'] = images;
    data['suggestion'] = suggestion;
    if (taxes != null) {
      data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    }
    // if (promotion != null) {
    //   data['promotion'] = promotion!.toJson();
    // }
    return data;
  }
}

class Shipping {
  String? deliveryPrice;
  String? deliveryTime;
  String? returnDays;

  Shipping({this.deliveryPrice, this.deliveryTime, this.returnDays});

  Shipping.fromJson(Map<String, dynamic> json) {
    deliveryPrice = json['deliveryPrice'];
    deliveryTime = json['deliveryTime'];
    returnDays = json['returnDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliveryPrice'] = deliveryPrice;
    data['deliveryTime'] = deliveryTime;
    data['returnDays'] = returnDays;
    return data;
  }
}

class Price {
  String? value;
  String? currency;
  String? discount;

  Price({this.value, this.currency, this.discount});

  Price.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['currency'] = currency;
    data['discount'] = discount;
    return data;
  }
}

class Offers {
  String? offerId;
  String? expirationDate;
  String? percentage;
  String? priceCurrency;

  Offers(
      {this.offerId, this.expirationDate, this.percentage, this.priceCurrency});

  Offers.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'];
    expirationDate = json['expirationDate'];
    percentage = json['percentage'];

    priceCurrency = json['priceCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offerId'] = offerId;
    data['expirationDate'] = expirationDate;
    data['percentage'] = percentage;

    data['priceCurrency'] = priceCurrency;
    return data;
  }
}

class Rivews {
  List<ReviewRating>? reviewRating;
  String? ratingValue;
  String? reviewCount;

  Rivews({this.reviewRating, this.ratingValue, this.reviewCount});

  Rivews.fromJson(Map<String, dynamic> json) {
    if (json['reviewRating'] != null) {
      reviewRating = <ReviewRating>[];
      json['reviewRating'].forEach((v) {
        reviewRating!.add(ReviewRating.fromJson(v));
      });
    }
    ratingValue = json['ratingValue'];
    reviewCount = json['reviewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviewRating != null) {
      data['reviewRating'] = reviewRating!.map((v) => v.toJson()).toList();
    }
    data['ratingValue'] = ratingValue;
    data['reviewCount'] = reviewCount;
    return data;
  }
}

class ReviewRating {
  String? ratingValue;
  String? author;
  String? description;

  ReviewRating({this.ratingValue, this.author, this.description});

  ReviewRating.fromJson(Map<String, dynamic> json) {
    ratingValue = json['ratingValue'];
    author = json['author'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ratingValue'] = ratingValue;
    data['author'] = author;
    data['description'] = description;
    return data;
  }
}

class Variant {
  String? color;
  List<Subvariant>? subvariant;

  Variant({this.color, this.subvariant});
  Variant copyWith({
    String? color,
    List<Subvariant>? subvariant,
  }) =>
      Variant(
        color: color ?? this.color,
        subvariant: subvariant ?? this.subvariant,
      );
  Variant.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    if (json['subvariant'] != null) {
      subvariant = <Subvariant>[];
      json['subvariant'].forEach((v) {
        subvariant!.add(Subvariant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    if (subvariant != null) {
      data['subvariant'] = subvariant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subvariant {
  String? size;
  String? price;
  String? stock;

  Subvariant({this.size, this.price, this.stock});
  Subvariant copyWith({
    String? size,
    String? price,
    String? stock,
  }) =>
      Subvariant(
        size: size ?? this.size,
        price: price ?? this.price,
        stock: stock ?? this.stock,
      );
  Subvariant.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    price = json['price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['price'] = price;
    data['stock'] = stock;
    return data;
  }
}

class Package {
  Weight? weight;
  Dimensions? dimensions;

  Package({this.weight, this.dimensions});

  Package.fromJson(Map<String, dynamic> json) {
    weight = json['weight'] != null ? Weight.fromJson(json['weight']) : null;
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (weight != null) {
      data['weight'] = weight!.toJson();
    }
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    return data;
  }
}

class Weight {
  String? value;
  String? unit;

  Weight({this.value, this.unit});

  Weight.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;
  String? unit;
  Dimensions({this.length, this.width, this.height, this.unit});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['unit'] = unit;
    return data;
  }
}

class Taxes {
  String? country;
  String? rate;
  String? region;
  String? taxShip;

  Taxes({this.country, this.rate, this.region, this.taxShip});

  Taxes.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    rate = json['rate'];
    region = json['region'];
    taxShip = json['taxShip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['rate'] = rate;
    data['region'] = region;
    data['taxShip'] = taxShip;
    return data;
  }
}

// class Promotion {
//   String? percentage;
//   String? expirationDate;

//   Promotion({this.percentage, this.expirationDate});

//   Promotion.fromJson(Map<String, dynamic> json) {
//     percentage = json['percentage'];
//     expirationDate = json['expirationDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};

//     data['percentage'] = percentage;

//     data['expirationDate'] = expirationDate;
//     return data;
//   }
// }
