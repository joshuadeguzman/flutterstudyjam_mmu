// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/models/cart.model.dart';
import 'package:flutter_provider_examples/example_4_shop/models/history.model.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class ShopHistory extends StatefulWidget {
  @override
  _ShopHistoryState createState() => _ShopHistoryState();
}

class _ShopHistoryState extends State<ShopHistory> {
  CartViewModel cartViewModel;

  @override
  void didChangeDependencies() {
    cartViewModel = Provider.of<CartViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ShopHistoryList(
        orderHistory: cartViewModel.orderHistory,
      ),
    );
  }
}

class _ShopHistoryList extends StatelessWidget {
  const _ShopHistoryList({
    Key key,
    this.orderHistory,
  }) : super(key: key);

  final List<History> orderHistory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(24),
      itemCount: orderHistory.length,
      itemBuilder: (_, i) => _ShopHistoryListItem(
        history: orderHistory[i],
      ),
    );
  }
}

class _ShopHistoryListItem extends StatelessWidget {
  const _ShopHistoryListItem({
    Key key,
    this.history,
  }) : super(key: key);
  final History history;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            padding: const EdgeInsets.only(top: 12, left: 12),
            child: Text(
              "Ordered last ${history.createdAt}",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          Container(
            height: 120,
            child: _HistoryCartList(
              items: history.items,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCartList extends StatelessWidget {
  const _HistoryCartList({
    Key key,
    this.items,
  }) : super(key: key);

  final List<Cart> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (_, i) => _HistoryCartListItem(
        cart: items[i],
      ),
    );
  }
}

class _HistoryCartListItem extends StatelessWidget {
  const _HistoryCartListItem({
    Key key,
    this.cart,
  }) : super(key: key);
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Image.network(
              cart.items.first.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "${cart.items.length} x ${cart.items.first.name}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            cart.items.first.category,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
