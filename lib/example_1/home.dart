// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.isAuthenticated}) : super(key: key);

  final bool isAuthenticated;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.isAuthenticated
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
