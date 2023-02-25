import 'package:flutter/material.dart';

class PersonalizationScreen extends StatefulWidget {
  final List<String> selectedAllergens;
  final Function(List<String>) onSelectionChanged;

  const PersonalizationScreen({
    required this.selectedAllergens,
    required this.onSelectionChanged,
  });

  @override
  _PersonalizationScreenState createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<String> _allergens;

  @override
  void initState() {
    super.initState();

    // Initialize the list of available allergens
    _allergens = [
      'Dairy',
      'Eggs',
      'Gluten',
      'Peanuts',
      'Tree nuts',
      'Soy',
      'Fish',
      'Shellfish',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalization'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSelectionChanged(widget.selectedAllergens);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text(
                'Please select any allergies you have:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _allergens.length,
                itemBuilder: (BuildContext context, int index) {
                  String allergen = _allergens[index];
                  bool isSelected = widget.selectedAllergens.contains(allergen);

                  return CheckboxListTile(
                    title: Text(allergen),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          widget.selectedAllergens.add(allergen);
                        } else {
                          widget.selectedAllergens.remove(allergen);
                        }
                      });
                    },
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
