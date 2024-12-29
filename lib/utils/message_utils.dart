import 'package:flutter/material.dart';

showMessageBar(String contexts, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(contexts),
    duration: Duration(seconds: 3),
  ));
}
var secretKey = "sk_test_4eC39HqLyjWDarjtT1zdp7dc";