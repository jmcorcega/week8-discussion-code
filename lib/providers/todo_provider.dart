/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../api/firebase_todo_api.dart';

class TodoListProvider with ChangeNotifier {
  List<Todo> _todoList = [];
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  List<Todo> get todo => _todoList;
  Stream<QuerySnapshot> get todos => _todosStream;

  fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editTodo(String id, String newTitle) async {
    String message = await firebaseService.editTodo(id, newTitle);
    print(message);
    notifyListeners();
  }

  void deleteTodo(String id) async {
    String message = await firebaseService.deleteTodo(id);
    print(message);
    notifyListeners();
  }

  void toggleStatus(String id, bool newState) async {
    String message = await firebaseService.toggleTodo(id, newState);
    print(message);
    notifyListeners();
  }
}
