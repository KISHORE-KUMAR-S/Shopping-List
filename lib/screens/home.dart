import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/model/grocery_item_model.dart';
import 'package:shopping_list/screens/new_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _groceryItems = [];
  // var _isLoading = true;
  late Future<List<GroceryItem>> _loadedItems;
  // String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'shopping-list-a7936-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list.json');

    // try {
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later.';
      // });
      throw Exception('Failed to fetch data. Please try again later.');
    }

    if (response.body == 'null') {
      // setState(() {
      //   _isLoading = false;
      // });
      // return;
      return [];
    }

    List<GroceryItem> loadedItems = [];

    final Map<String, dynamic> result = json.decode(response.body);

    for (final item in result.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          item.key,
          item.value['name'],
          item.value['quantity'],
          category,
        ),
      );
    }

    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading = false;
    // });

    // catch (e) {
    //   setState(() {
    //     _error = 'Something went wrong.';
    //   });
    // }
    return loadedItems;
  }

  void _addItem() async {
    // ignore: prefer_typing_uninitialized_variables
    final newItem;

    if (Platform.isIOS) {
      newItem = await Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => const NewItem(),
      ));
    } else {
      newItem = await Navigator.of(context).push<GroceryItem>(
          MaterialPageRoute(builder: (context) => const NewItem()));
    }

    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
        'shopping-list-a7936-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      const ScaffoldMessenger(child: Text('Error while deleting item.'));

      setState(() {
        // _groceryItems.add(item);
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = const Center(
    //   child: Text('No items added yet.'),
    // );

    // if (_isLoading) {
    //   content = const Center(
    //     child: CircularProgressIndicator.adaptive(),
    //   );
    // }

    // if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: _groceryItems.length,
    //     itemBuilder: (context, index) => Dismissible(
    //       key: ValueKey(_groceryItems[index].id),
    //       onDismissed: (direction) => _removeItem(_groceryItems[index]),
    //       child: ListTile(
    //         title: Text(_groceryItems[index].name),
    //         leading: Container(
    //           width: 24,
    //           height: 24,
    //           color: _groceryItems[index].category.color,
    //         ),
    //         trailing: Text(_groceryItems[index].quantity.toString()),
    //       ),
    //     ),
    //   );
    // }

    // if (_error != null) {
    //   content = Center(child: Text(_error!));
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No items added yet.'));
          }
          return ListView.builder(
            // itemCount: _groceryItems.length,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              onDismissed: (direction) => _removeItem(snapshot.data![index]),
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(snapshot.data![index].quantity.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
