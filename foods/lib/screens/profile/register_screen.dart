import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/food/food_screen.dart';
import 'package:foods/screens/profile/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  final Function(UserModel) onCreate;
  const RegisterScreen({Key? key, required this.onCreate}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';

  late SharedPreferences logindata;
  late bool newUser;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void initial() async {
    // Function(UserModel) onCreate;
    logindata = await SharedPreferences.getInstance();
    newUser = logindata.getBool('register') ?? true;
    setState(() {
      username = logindata.getString('name').toString();
      email = logindata.getString('email').toString();
      password = logindata.getString('password').toString();
      phone = logindata.getString('phone').toString();
      address = logindata.getString('address').toString();
    });
    newUser = logindata.getBool('register') ?? true;
    if (newUser == false) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginScreen(onCreate: (user) {
            
      //     },)),
      //     (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
    _nameController.addListener((){
      setState(() {
        username = _nameController.text;
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
    _phoneController.addListener(() {
      setState(() {
        phone = _phoneController.text;
      });
    });
    _addressController.addListener(() {
      setState(() {
        address = _addressController.text;    
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register', style: TextStyle(fontFamily: 'Merriweather', fontSize: 17),),
      ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle_rounded),
                hintText: 'Username',
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
              ),
              validator: (value) {
                if (value != null && value.length < 4) {
                  return 'Enter at least 4 characters';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.black,
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
              ),
              validator: (email) {
                if (email != null && EmailValidator.validate(email)) {
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
              cursorColor: Colors.black,
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
              ),
              validator: (value) {
                if (value != null && value.length < 5) {
                  return 'Enter min. 5 characters';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _phoneController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.call),
                hintText: 'Phone',
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
              ),
              validator: (phone) {
                if (phone != null && phone.length <= 12) {
                  return 'Enter max 12 number';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _addressController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home),
                hintText: 'Address',
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
              ),
              validator: (value) {
                if (value != null) {
                  return null;
                }
              },
            ),
             const SizedBox(height: 16),
                ElevatedButton(
        onPressed: () {
          final isValidForm = formKey.currentState!.validate();
          if (isValidForm) {
            logindata.setBool('register', true);
            logindata.setString('username', username);
            logindata.setString('email', email);
            logindata.setString('password', password);
            logindata.setString('phone', phone);
            logindata.setString('address', address);
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => LoginScreen(onCreate: userItem)),
            //     (route) => false);
          }
          final userItem = UserModel(
              id: Uuid().v1(),
              name: username,
              email: email,
              password: password,
              phone: phone,
              address: address
              );
          widget.onCreate(userItem);
        },
        autofocus: false,
        child: const Text('Register')),
                const SizedBox(
              height: 8,
            ),
          ],
        )),
            )));
  }

}
