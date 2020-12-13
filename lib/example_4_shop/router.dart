// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/checkout/checkout_page.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/dashboard_page.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => DashboardViewModel(),
            child: DashboardPage(),
          ),
        );
      case CheckoutPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => null,
            child: CheckoutPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Undefined route: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
