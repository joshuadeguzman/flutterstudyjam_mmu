// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/models/cart.model.dart';
import 'package:flutter_provider_examples/example_4_shop/models/history.model.dart';
import 'package:flutter_provider_examples/example_4_shop/models/item.model.dart';

class CartViewModel extends ChangeNotifier {
  final List<History> orderHistory = [];

  final List<Cart> items = [];

  int get cartCount => items != null ? _getTotalItems() : 0;

  bool get showShopItems => items != null && items.isNotEmpty;

  String get cartLabel =>
      cartCount == 0 ? "Cart is empty" : "Cart ($cartCount)";

  bool get enableCheckoutButton => cartCount > 0;

  bool get showConfirmCheckoutButton => cartCount > 0;

  void addItemToCart(Item item) {
    final cart = items.where((e) => e.itemId == item.id);
    if (cart.length > 0) {
      cart.first.items.add(item);
    } else {
      items.add(Cart(
        itemId: item.id,
        items: List.of([item]),
      ));
    }
    notifyListeners();
  }

  void removeItemFromCart(Item item) {
    if (items.isNotEmpty) {
      final cart = items.where((e) => e.itemId == item.id);
      if (cart.length > 0) {
        cart.first.items.remove(item);
        if (cart.first.items.length <= 0) items.remove(cart.first);
      }
    }
    notifyListeners();
  }

  int _getTotalItems() {
    var total = 0;
    if (items.length > 0) {
      items.forEach((cart) {
        total += cart.items.length;
      });

      return total;
    }

    return 0;
  }

  void checkoutItems() {
    // Store transactions
    orderHistory.add(History(
      createdAt: DateTime.now(),
      items: items.toList(),
    ));

    // Reset current in-app transactions
    items.clear();

    notifyListeners();
  }
}
