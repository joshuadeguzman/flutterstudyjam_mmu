// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/models/item.model.dart';

class ShopViewModel extends ChangeNotifier {
  final List<Item> _mockShopItems = [
    Item(
      id: 0,
      name: "PS5 Console",
      category: "Games",
      imageUrl: "https://via.placeholder.com/400x150.jpg",
    ),
    Item(
      id: 1,
      name: "Nintendo Switch V2",
      category: "Games",
      imageUrl: "https://via.placeholder.com/400x150.jpg",
    ),
    Item(
      id: 2,
      name: "PSP",
      category: "Games",
      imageUrl: "https://via.placeholder.com/400x150.jpg",
    ),
  ];

  List<Item> shopItems = [];

  bool get showShopItems => shopItems != null && shopItems.isNotEmpty;

  void getItems() {
    shopItems = _mockShopItems;
    notifyListeners();
  }
}
