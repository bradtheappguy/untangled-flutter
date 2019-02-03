// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

class ArchSampleTheme {
  static get theme {
    final originalTextTheme = ThemeData.light().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return ThemeData(
        fontFamily: "Catamaran",
        primaryColor: Color.fromRGBO(22, 22, 28, 1),
        accentColor: Colors.cyan[300],
        buttonColor: Colors.red,
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.white,
        toggleableActiveColor: Colors.cyan[300],
        textTheme: originalTextTheme.copyWith(
            subhead: originalBody1.copyWith(decorationColor: Colors.blue),
            headline: originalBody1.copyWith(decorationColor: Colors.blue),
            title: originalBody1.copyWith(decorationColor: Colors.blue),
            body1:
                originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}
