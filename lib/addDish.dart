import 'package:flutter/material.dart';
import 'package:makeathon/login.dart';

class AddDish extends StatefulWidget {
  const AddDish({Key? key}) : super(key: key);

  @override
  State<AddDish> createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final TextEditingController _titleCOntroller = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _instController = TextEditingController();
  final TextEditingController _ingController = TextEditingController();
  final TextEditingController _cuisineCOntroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleCOntroller.dispose();
    _descController.dispose();
    _cuisineCOntroller.dispose();
    _ingController.dispose();
    _instController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 80,
      ),

      //username textfield

      InputTextField(
        hintText: 'Enter Dish Name',
        textInputType: TextInputType.text,
        textEditingController: _titleCOntroller,
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
        textInputType: TextInputType.emailAddress,
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
        isPass: true,
      ),

      const SizedBox(
        height: 24,
      ),
      InputTextField(
        hintText: 'Enter the Cuisine',
        textInputType: TextInputType.text,
        textEditingController: _cuisineCOntroller,
      ),

      const SizedBox(
        height: 24,
      ),

      // DropdownButtonFormField(
      //     items: const [
      //       DropdownMenuItem(child: Text('Investor')),
      //       DropdownMenuItem(child: Text('Innovator')),
      //     ],
      //     onChanged: (sel) {
      //       _type = sel;
      //     }),

      //button
      // ElevatedButton(
      //   onPressed: () async {
      //     String res = await AuthMethods().SignupUser(
      //       email: _emailController.text,
      //       password: _passwordController.text,
      //       username: _usernameController.text,
      //       type: _type,
      //       age: _ageController.text,
      //       allergens: _allergenController.text,
      //       favDish: _dishController.text,
      //     );
      //     if (res == 'success') {
      //       Navigator.of(context).pushAndRemoveUntil(
      //           MaterialPageRoute(builder: (context) => DashboardScreen()),
      //           (Route<dynamic> route) => false);
      //     }
      //   },
      //   child: Container(
      //     width: double.infinity,
      //     alignment: Alignment.center,
      //     padding: const EdgeInsets.symmetric(vertical: 12),
      //     decoration: const ShapeDecoration(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(4),
      //         ),
      //       ),
      //     ),
      //     child: const Text("Sign In"),
      //   ),
      // ),
      const SizedBox(
        height: 22,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text("Already have an account?"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
