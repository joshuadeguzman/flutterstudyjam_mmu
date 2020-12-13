// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/models/item.model.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/shop/viewmodel/shop_viewmodel.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with AutomaticKeepAliveClientMixin {
  ShopViewModel shopViewModel;
  CartViewModel cartViewModel;

  @override
  void didChangeDependencies() {
    shopViewModel = Provider.of<ShopViewModel>(context);
    cartViewModel = Provider.of<CartViewModel>(context);

    // Request for the items after widgets are displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shopViewModel.getItems();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Container(
        child: shopViewModel.showShopItems
            ? _ShopList(
                items: shopViewModel.shopItems,
                onItemAdded: cartViewModel.addItemToCart,
                onItemRemoved: cartViewModel.removeItemFromCart,
              )
            : Center(
                child: Text("No shop items found"),
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ShopList extends StatelessWidget {
  const _ShopList({
    Key key,
    this.items,
    this.onItemAdded,
    this.onItemRemoved,
  }) : super(key: key);

  final List<Item> items;
  final Function(Item item) onItemAdded;
  final Function(Item item) onItemRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      itemBuilder: (_, i) => _ShopListItem(
        item: items[i],
        onItemAdded: onItemAdded,
        onItemRemoved: onItemRemoved,
      ),
    );
  }
}

class _ShopListItem extends StatelessWidget {
  const _ShopListItem({
    Key key,
    this.item,
    this.onItemAdded,
    this.onItemRemoved,
  }) : super(key: key);
  final Item item;
  final Function(Item item) onItemAdded;
  final Function(Item item) onItemRemoved;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12),
          Text(
            item.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: () {
                  if (onItemRemoved != null) onItemRemoved(item);
                },
                color: Colors.red,
                child: Text(
                  "Remove",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              RaisedButton(
                onPressed: () {
                  if (onItemRemoved != null) onItemAdded(item);
                },
                color: Colors.green,
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
