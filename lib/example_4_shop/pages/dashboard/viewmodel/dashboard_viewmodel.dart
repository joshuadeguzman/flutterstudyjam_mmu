// Copyright 2020 Joshua de Guzman (contact@joshuadeguzman.net). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  void updatePageIndex(int page) {
    this._pageIndex = page;
    notifyListeners();
  }
}
