// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:fire_redux_sample/containers/app_loading.dart';
import 'package:fire_redux_sample/containers/todo_details.dart';
import 'package:fire_redux_sample/flutter_architecture_samples.dart';
import 'package:fire_redux_sample/models/models.dart';
import 'package:fire_redux_sample/presentation/loading_indicator.dart';
import 'package:fire_redux_sample/presentation/todo_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo, bool) onCheckboxChanged;
  final Function(Todo) onRemove;
  final Function(Todo) onUndoRemove;

  String _task;

  TodoList({
    Key key,
    @required this.todos,
    @required this.onCheckboxChanged,
    @required this.onRemove,
    @required this.onUndoRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: <Widget>[
            AppLoading(builder: (context, loading) {
              return loading
                  ? LoadingIndicator(key: ArchSampleKeys.todosLoading)
                  : Expanded(child: _buildListView());
            }),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  initialValue: '',
                  key: ArchSampleKeys.taskField,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "I am going to...",
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? "Empty Error" : null;
                  },
                  onSaved: (value) => _task = value,
                ))
          ],
        ));
  }

  ListView _buildListView() {
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];

        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            _removeTodo(context, todo);
          },
          onTap: () => _onTodoTap(context, todo),
          onCheckboxChanged: (complete) {
            onCheckboxChanged(todo, complete);
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, Todo todo) {
    onRemove(todo);

    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          "Deleted",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => onUndoRemove(todo),
        )));
  }

  void _onTodoTap(BuildContext context, Todo todo) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (_) => TodoDetails(id: todo.id),
    ))
        .then((removedTodo) {
      if (removedTodo != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            key: ArchSampleKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text(
              "Deleted",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                onUndoRemove(todo);
              },
            )));
      }
    });
  }
}
