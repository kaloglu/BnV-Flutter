import 'package:bnv/data/repository/interfaces/repository.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel<R extends Repository> extends ChangeNotifier {
  R _repository;
  bool _busy = false;

  bool get busy => _busy;

  set busy(value) {
    _busy = value;
    notifyListeners();
  }

  R get repository => _repository;

  set repository(value) => _repository = value;
}
