import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/food/food_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  final Function(UserModel) onCreate;
  const LoginScreen({Key? key, required this.onCreate}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final SharedPreferences logindata;
  String email = '';
  String password = '';
  late bool newUser;

  final formKey = GlobalKey<FormState>();

  checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email').toString();
      password = logindata.getString('password').toString();
    });
    newUser = logindata.getBool('login') ?? true;
    if (newUser == false) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const FoodScreen()),
        (route) => false);
    }
  }

  @override
  void initState()  {
    super.initState();
    
    checkLogin().whenComplete(() {
      setState(() {
        email = _emailController.text;
        password = _passwordController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login', style: TextStyle(fontFamily: 'Merriweather', fontSize: 17)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(children: [
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusColor: Colors.black),
                validator: (email) {
                  if (email != null && EmailValidator.validate(email,false, true)) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusColor: Colors.black),
                  validator: (value) {
                    if (value != null && value.length < 5) {
                      return 'Enter min. 5 characters';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    // UserViewModel? viewModel;
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      email = _emailController.text;
                      password = _passwordController.text;

                      logindata.setBool('login', true);                      
                      logindata.setString('email', email);

                      final userItem = UserModel(
                          id: Uuid().v1(),
                          email: email,
                          password: password);
                      widget.onCreate(userItem);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FoodScreen()),
                          (route) => false);
                      //   viewModel!.doLogin(
                      //       _emailController.text, _passwordController.text);
                      // }
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }

  // void _validateInputs() {
  //   // final userItem = UserModel(
  //   //     id: Uuid().v1(),
  //   //     name: name,
  //   //     email: email,
  //   //     password: password,
  //   //     phone: '',
  //   //     address: '');
  //   // // widget.onCreate(userItem);
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => const FoodScreen()),
  //       (route) => false);
  //   // }
  // }
}
