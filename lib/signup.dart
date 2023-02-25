import 'package:flutter/material.dart';
import 'package:makeathon/auth_functions.dart';
import 'package:makeathon/home.dart';
import 'package:makeathon/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final String _type = 'Innovator';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),

            const SizedBox(
              height: 44,
            ),

            //username textfield

            InputTextField(
              hintText: 'Enter your Username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),

            const SizedBox(
              height: 24,
            ),

            InputTextField(
              hintText: 'Enter your age',
              textInputType: TextInputType.text,
              textEditingController: _ageController,
            ),

            const SizedBox(
              height: 24,
            ),

            //email textfield
            InputTextField(
              hintText: 'Enter your Email Address',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),

            //password textfield
            InputTextField(
              hintText: 'Enter your Password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
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
            InkWell(
              onTap: () async {
                String res = await AuthMethods().SignupUser(
                  email: _emailController.text,
                  password: _passwordController.text,
                  username: _usernameController.text,
                  type: _type,
                  age: _ageController.text,
                  //allergens: _allergens,
                );
                if (res == 'success') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false);
                }
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
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      //body: Text("Login Page"),
    );
  }
}
