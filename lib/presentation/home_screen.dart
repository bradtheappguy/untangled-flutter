// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/containers/active_tab.dart';
import 'package:fire_redux_sample/containers/extra_actions_container.dart';
import 'package:fire_redux_sample/containers/filter_selector.dart';
import 'package:fire_redux_sample/containers/filtered_todos.dart';
import 'package:fire_redux_sample/containers/stats.dart';
import 'package:fire_redux_sample/containers/tab_selector.dart';
import 'package:fire_redux_sample/flutter_architecture_samples.dart';
import 'package:fire_redux_sample/models/models.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Container(
            child: Scaffold(
          appBar: AppBar(
            title: Padding(
                padding: EdgeInsets.all(5.0),
                child: Image(image: AssetImage('assets/0.png'))),
            actions: [
              FilterSelector(visible: activeTab == AppTab.todos),
              ExtraActionsContainer(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: "Add Todos",
          ),
          bottomNavigationBar: TabSelector(),
        ));
      },
    );
  }
}
