import 'package:flutter/material.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<String> _mealPlan = [
    'Monday - Spaghetti and Meatballs',
    'Tuesday - Chicken Tacos',
    'Wednesday - Salmon and Asparagus',
    'Thursday - Beef Stew',
    'Friday - Pizza Night',
    'Saturday - Grilled Cheese and Tomato Soup',
    'Sunday - Roast Chicken'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Your Meal Plan:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _mealPlan.length,
                itemBuilder: (BuildContext context, int index) {
                  String meal = _mealPlan[index];

                  return ListTile(
                    title: Text(meal),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog where the user can add a new meal to the meal plan
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newMeal = '';

              return AlertDialog(
                title: const Text('Add a New Meal'),
                content: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter the name of the new meal',
                  ),
                  onChanged: (value) {
                    newMeal = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add the new meal to the meal plan and close the dialog
                      setState(() {
                        _mealPlan.add(newMeal);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
