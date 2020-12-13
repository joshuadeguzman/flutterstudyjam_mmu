// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_provider_examples/example_3/user_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel;

  @override
  void didChangeDependencies() {
    userModel = Provider.of<UserModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userModel.isLoggedIn
                ? Text(
                    'Welcome Joshua!',
                  )
                : Text(
                    'You are logged out!',
                  ),
          ],
        ),
      ),
    );
  }
}
