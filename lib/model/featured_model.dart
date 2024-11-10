import 'dart:convert';

class Product {
  final int actualPrice;
  final List<dynamic> addons;
  final String category;
  final String collectionId;
  final String collectionName;
  final String created;
  final String description;
  final int discountPrice;
  final Expand expand;
  final dynamic extras;
  final bool featured;
  final String id;
  final List<String> images;
  final String name;
  final String slug;
  final String updated;

  Product({
    required this.actualPrice,
    required this.addons,
    required this.category,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.description,
    required this.discountPrice,
    required this.expand,
    this.extras,
    required this.featured,
    required this.id,
    required this.images,
    required this.name,
    required this.slug,
    required this.updated,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      actualPrice: json['actual_price'],
      addons: json['addons'],
      category: json['category'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: json['created'],
      description: json['description'],
      discountPrice: json['discount_price'],
      expand: Expand.fromJson(json['expand']),
      extras: json['extras'],
      featured: json['featured'],
      id: json['id'],
      images: List<String>.from(json['images']),
      name: json['name'],
      slug: json['slug'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actual_price': actualPrice,
      'addons': addons,
      'category': category,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'description': description,
      'discount_price': discountPrice,
      'expand': expand.toJson(),
      'extras': extras,
      'featured': featured,
      'id': id,
      'images': images,
      'name': name,
      'slug': slug,
      'updated': updated,
    };
  }
}

class Expand {
  final Category category;
  final List<Variant> variantsViaProduct;

  Expand({
    required this.category,
    required this.variantsViaProduct,
  });

  factory Expand.fromJson(Map<String, dynamic> json) {
    return Expand(
      category: Category.fromJson(json['category']),
      variantsViaProduct: json['variants_via_product'] != null
          ? (json['variants_via_product'] as List)
              .map((item) => Variant.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category.toJson(),
      'variants_via_product':
          variantsViaProduct.map((variant) => variant.toJson()).toList(),
    };
  }
}

class Category {
  final String collectionId;
  final String collectionName;
  final String created;
  final String description;
  final String id;
  final String image;
  final String slug;
  final String title;
  final String updated;

  Category({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.description,
    required this.id,
    required this.image,
    required this.slug,
    required this.title,
    required this.updated,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: json['created'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      slug: json['slug'],
      title: json['title'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'description': description,
      'id': id,
      'image': image,
      'slug': slug,
      'title': title,
      'updated': updated,
    };
  }
}

class Variant {
  final String collectionId;
  final String collectionName;
  final String created;
  final int discountPriceChange;
  final String group;
  final String id;
  final List<dynamic> images;
  final String name;
  final int priceChange;
  final String product;
  final String updated;

  Variant({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.discountPriceChange,
    required this.group,
    required this.id,
    required this.images,
    required this.name,
    required this.priceChange,
    required this.product,
    required this.updated,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: json['created'],
      discountPriceChange: json['discount_price_change'],
      group: json['group'],
      id: json['id'],
      images: json['images'],
      name: json['name'],
      priceChange: json['price_change'],
      product: json['product'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'discount_price_change': discountPriceChange,
      'group': group,
      'id': id,
      'images': images,
      'name': name,
      'price_change': priceChange,
      'product': product,
      'updated': updated,
    };
  }
}
