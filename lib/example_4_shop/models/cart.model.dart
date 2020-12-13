// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter_provider_examples/example_4_shop/models/item.model.dart';

class Cart {
  final int itemId;
  final List<Item> items;

  Cart({
    this.itemId,
    this.items,
  });
}
