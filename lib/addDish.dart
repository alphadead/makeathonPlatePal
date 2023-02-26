import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeathon/login.dart';

class AddDish extends StatefulWidget {
  const AddDish({Key? key}) : super(key: key);

  @override
  State<AddDish> createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _instController = TextEditingController();
  final TextEditingController _ingController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _titleCOntroller.dispose();
  //   _descController.dispose();
  //   _cuisineCOntroller.dispose();
  //   _ingController.dispose();
  //   _instController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your dish!'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 80,
            ),

            //username textfield

            InputTextField(
              hintText: 'Enter Dish Name',
              textInputType: TextInputType.text,
              textEditingController: _titleController,
            ),

            const SizedBox(
              height: 24,
            ),

            InputTextField(
              hintText: 'Enter Dish Description',
              textInputType: TextInputType.text,
              textEditingController: _descController,
            ),

            const SizedBox(
              height: 24,
            ),

            //email textfield
            InputTextField(
              hintText: 'Enter Dish Ingredients',
              textInputType: TextInputType.text,
              textEditingController: _ingController,
            ),
            const SizedBox(
              height: 24,
            ),

            //password textfield
            InputTextField(
              hintText: 'Enter the Instructions',
              textInputType: TextInputType.text,
              textEditingController: _instController,
            ),

            const SizedBox(
              height: 24,
            ),
            InputTextField(
              hintText: 'Enter the Cuisine',
              textInputType: TextInputType.text,
              textEditingController: _cuisineController,
            ),

            const SizedBox(
              height: 24,
            ),

            //button
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> res = {
                  "cuisine": _cuisineController.text,
                  "name": _titleController.text,
                  "ingredients": _ingController.text,
                  "instructions": _instController.text,
                  "description": _descController.text,
                  'image_url': ''
                };

                FirebaseFirestore.instance.collection('recipes').add(res);

                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
                child: const Text("Save"),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
          ]),
        ),
      ),
    );
  }
}
