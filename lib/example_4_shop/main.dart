// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_4_shop/pages/dashboard/dashboard_page.dart';
import 'package:flutter_provider_examples/example_4_shop/router.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/auth_viewmodel.dart';
import 'package:flutter_provider_examples/example_4_shop/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Example4ShopApp());
}

class Example4ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter E-commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: DashboardPage.routeName,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
