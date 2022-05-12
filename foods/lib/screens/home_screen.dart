import 'package:flutter/material.dart';
import 'package:foods/screens/profile/login_screen.dart';
import 'package:foods/screens/profile/profile_screen.dart';
import 'package:foods/screens/profile/register_screen.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.red[800],
    minimumSize: const Size(200, 50),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
  final String imagePath =
      "https://images.unsplash.com/photo-1601887031610-d72bf3987fb2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<UserViewModel>(context, listen: false).getAllUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.exclusion),
              opacity: (0.5),
              image: NetworkImage(imagePath),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Image.asset(
                'assets/icon_mayfoods.png',
                width: 48,
                height: 56,
              ),
              const SizedBox(
                height: 20,
              ),
              welcomeTextWidget(),
              const SizedBox(
                height: 10,
              ),
              sloganText(),
              const SizedBox(
                height: 40,
              ),
              getLogin(context),
              const SizedBox(
                height: 40,
              ),
              getRegister(context),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.red),
        ),
        Text(
          "to our delivery",
          style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.red),
        ),
      ],
    );
  }

  Widget sloganText() {
    return Text(
      "home cooking delivery",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red[500]),
    );
  }

  Widget getLogin(BuildContext context) {
    final modelView = Provider.of<UserViewModel>(context, listen: false);
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return LoginScreen(
            onCreate: (user) {
              modelView.addUser(user);
              Navigator.pop(context);
            },
          );
        }));
      },
      child: const Text('Login',
          style: TextStyle(
            fontFamily: 'Merriweather',
            // fontWeight: FontWeight.w600,
          )),
    );
  }

  Widget getRegister(BuildContext context) {
    final modelView = Provider.of<UserViewModel>(context, listen: false);
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return RegisterScreen(
            onCreate: (user) {
              modelView.addUser(user);
              Navigator.pop(context);
            },
          );
        }));
      },
      child: const Text('Register',
          style: TextStyle(
            fontFamily: 'Merriweather',
            // fontWeight: FontWeight.w600,
          )),
    );
  }
}
