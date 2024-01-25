import 'package:flutter/material.dart';

enum Categories {
  dairy,
  fruit,
  hygeine,
  convenience,
  carbs,
  vegetables,
  meat,
  spices,
  sweets,
  other,
}

class Category {
  const Category(this.title, this.color);

  final String title;
  final Color color;
}
