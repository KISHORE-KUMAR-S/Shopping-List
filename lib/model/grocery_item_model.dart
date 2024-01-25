import 'package:shopping_list/model/category.dart';

class GroceryItem {
  const GroceryItem(this.id, this.name, this.quantity, this.category);

  final String id, name;
  final int quantity;
  final Category category;
}
