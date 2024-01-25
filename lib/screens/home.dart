import 'package:flutter/material.dart';
import 'package:shopping_list/data/grocery_items.dart';
import 'package:shopping_list/screens/new_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // final List<Category> samples = [
    //   Category(color: Colors.blue, text: 'Milk', number: 1),
    //   Category(color: Colors.green, text: 'Bananas', number: 5),
    //   Category(color: Colors.orangeAccent, text: 'Fish', number: 1),
    // ];

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
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
