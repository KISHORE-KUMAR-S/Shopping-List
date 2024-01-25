import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/category.dart';
import 'package:shopping_list/model/grocery_item_model.dart';

List<GroceryItem> groceryItems = [
  GroceryItem('a', 'Milk', 1, categories[Categories.dairy]!),
  GroceryItem('b', 'Bananas', 5, categories[Categories.fruit]!),
  GroceryItem('c', 'Fish', 1, categories[Categories.meat]!),
];
