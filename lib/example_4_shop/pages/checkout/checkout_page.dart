// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/models/cart.model.dart';
import 'package:flutter_provider_examples/example_4_shop/models/item.model.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/dashboard_page.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = "/checkout-page";

  @override
  State<StatefulWidget> createState() {
    return _CheckoutPageState();
  }
}

class _CheckoutPageState extends State<CheckoutPage> {
  CartViewModel cartViewModel;

  @override
  void didChangeDependencies() {
    cartViewModel = Provider.of<CartViewModel>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout Page"),
        actions: [
          cartViewModel.showConfirmCheckoutButton
              ? FlatButton(
                  onPressed: () {
                    cartViewModel.checkoutItems();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      DashboardPage.routeName,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
        ],
      ),
      body: Container(
        child: cartViewModel.showShopItems
            ? _CheckoutCartList(
                items: cartViewModel.items,
                onItemAdded: cartViewModel.addItemToCart,
                onItemRemoved: cartViewModel.removeItemFromCart,
              )
            : Center(
                child: Text("No shop items found"),
              ),
      ),
    );
  }
}

class _CheckoutCartList extends StatelessWidget {
  const _CheckoutCartList({
    Key key,
    this.items,
    this.onItemAdded,
    this.onItemRemoved,
  }) : super(key: key);

  final List<Cart> items;
  final Function(Item item) onItemAdded;
  final Function(Item item) onItemRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      itemBuilder: (_, i) => _CheckoutCartListItem(
        cart: items[i],
        onItemAdded: onItemAdded,
        onItemRemoved: onItemRemoved,
      ),
    );
  }
}

class _CheckoutCartListItem extends StatelessWidget {
  const _CheckoutCartListItem({
    Key key,
    this.cart,
    this.onItemAdded,
    this.onItemRemoved,
  }) : super(key: key);
  final Cart cart;
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
            width: 150,
            child: Image.network(
              cart.items.first.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "${cart.items.length} x ${cart.items.first.name}",
            style: TextStyle(
              fontSize: 16,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: () {
                  if (onItemRemoved != null) onItemRemoved(cart.items.first);
                },
                color: Colors.red,
                child: Text(
                  "-",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              RaisedButton(
                onPressed: () {
                  if (onItemRemoved != null) onItemAdded(cart.items.first);
                },
                color: Colors.green,
                child: Text(
                  "+",
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
