// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/checkout/checkout_page.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/shop/shop.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/shop/viewmodel/shop_viewmodel.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/shop_history/shop_history.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/shop_history/viewmodel/shop_history_viewmodel.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = "/";

  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardViewModel dashboardViewModel;
  CartViewModel cartViewModel;

  PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      if (dashboardViewModel != null) {
        dashboardViewModel.updatePageIndex(pageController.page.toInt());
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dashboardViewModel = Provider.of<DashboardViewModel>(context);
    cartViewModel = Provider.of<CartViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazpee"),
        actions: [
          FlatButton(
            onPressed: () => cartViewModel.enableCheckoutButton
                ? Navigator.pushNamed(
                    context,
                    CheckoutPage.routeName,
                  )
                : null,
            child: Text(
              cartViewModel.cartLabel,
              style: TextStyle(
                color: cartViewModel.enableCheckoutButton
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            ChangeNotifierProvider(
              create: (_) => ShopViewModel(),
              child: Shop(),
            ),
            ChangeNotifierProvider(
              create: (_) => ShopHistoryViewModel(),
              child: ShopHistory(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: dashboardViewModel.pageIndex,
        onTap: (i) => pageController.animateToPage(
          i,
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
        ],
      ),
    );
  }
}
