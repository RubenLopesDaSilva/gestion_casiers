import 'package:flutter/material.dart';

class InputError<KeyType, ValueType> {
  Map<KeyType, ValueType> errors = {};

  bool get error => errors.isNotEmpty;

  void clear() {
    errors.clear();
  }

  void setEntry(KeyType key, ValueType value) {
    errors[key] = value;
  }

  Widget? errorMessage({
    required KeyType inputName,
    required Widget Function(ValueType?) child,
  }) {
    return errors[inputName] == null ? null : child(errors[inputName]);
  }
}
