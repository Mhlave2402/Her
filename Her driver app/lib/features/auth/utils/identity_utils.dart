import 'package:flutter/material.dart';

const Map<String, Map<String, dynamic>> identityTypes = {
  'National ID': {
    'label': 'National ID Number',
    'validation': _isNumeric,
    'keyboard': TextInputType.number,
  },
  'Passport': {
    'label': 'Passport Number',
    'validation': _isAlphanumeric,
    'keyboard': TextInputType.text,
  },
  'Driver\'s License': {
    'label': 'License Number',
    'validation': _isAlphanumeric,
    'keyboard': TextInputType.text,
  },
};

bool _isNumeric(String value) {
  if (value.isEmpty) {
    return false;
  }
  return double.tryParse(value) != null;
}

bool _isAlphanumeric(String value) {
  if (value.isEmpty) {
    return false;
  }
  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  return alphanumeric.hasMatch(value);
}
