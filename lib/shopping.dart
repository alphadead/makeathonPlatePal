import 'package:flutter/material.dart';

class ShoppingListScreen extends StatelessWidget {
  final List<String> ingredients;

  const ShoppingListScreen({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  String ingredient = ingredients[index];

                  return ListTile(
                    title: Text(ingredient),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
