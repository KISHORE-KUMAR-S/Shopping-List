import 'package:flutter/material.dart';
// import 'package:shopping_list/data/grocery_items.dart';
// import 'package:shopping_list/data/grocery_items.dart';
import 'package:shopping_list/model/grocery_item_model.dart';
import 'package:shopping_list/screens/new_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (context) => const NewItem()));

    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<Category> samples = [
    //   Category(color: Colors.blue, text: 'Milk', number: 1),
    //   Category(color: Colors.green, text: 'Bananas', number: 5),
    //   Category(color: Colors.orangeAccent, text: 'Fish', number: 1),
    // ];

    Widget content = const Center(
      child: Text('No items added yet.'),
    );

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) => _removeItem(_groceryItems[index]),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
