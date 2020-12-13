import 'package:flutter_provider_examples/example_4_shop/models/cart.model.dart';

class History {
  final DateTime createdAt;
  final List<Cart> items;

  History({
    this.createdAt,
    this.items,
  });
}
