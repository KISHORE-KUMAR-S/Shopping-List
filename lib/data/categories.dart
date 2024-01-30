import 'package:flutter/material.dart';
import 'package:shopping_list/model/category.dart';

Map<Categories, Category> categories = {
  Categories.dairy: const Category(
    'Dairy',
    Color.fromARGB(255, 173, 216, 230),
  ),
  Categories.fruit: const Category(
    'Fruit',
    Color.fromARGB(255, 255, 165, 0),
  ),
  Categories.hygeine: const Category(
    'Hygeine',
    Color.fromARGB(255, 201, 160, 220),
  ),
  Categories.convenience: const Category(
    'Convenience',
    Color.fromARGB(255, 128, 128, 128),
  ),
  Categories.carbs: const Category(
    'Carbs',
    Color.fromARGB(255, 255, 255, 0),
  ),
  Categories.vegetables: const Category(
    'Vegetables',
    Color.fromARGB(255, 0, 128, 0),
  ),
  Categories.meat: const Category(
    'Meat',
    Color.fromARGB(255, 139, 69, 19),
  ),
  Categories.spices: const Category(
    'Spices',
    Color.fromARGB(255, 255, 0, 0),
  ),
  Categories.sweets: const Category(
    'Sweets',
    Color.fromARGB(255, 255, 192, 203),
  ),
  Categories.other: const Category(
    'Others',
    Color.fromARGB(255, 211, 211, 211),
  )
};
