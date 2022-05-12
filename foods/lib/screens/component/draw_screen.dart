import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/cart/cart_screen.dart';
import 'package:foods/screens/category/category_screen.dart';
import 'package:foods/screens/component/favorite_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:foods/screens/profile/login_screen.dart';
import 'package:foods/screens/profile/profile_screen.dart';
import 'package:foods/screens/profile/user_preferences.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawWidget extends StatefulWidget {
  const DrawWidget({Key? key}) : super(key: key);

  @override
  State<DrawWidget> createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  SharedPreferences? logindata;
  String email = '';
  String password = '';

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata!.getString('email').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    initial().whenComplete(() {
      setState(() {
        email = logindata!.getString('email').toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<FoodViewModel>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _header(),
          _item(
            icon: Icons.person,
            text: 'Profile',
            // ignore: avoid_print
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                      // userModel: userModel,
                      ),
                ),
              ),
            },
          ),
          _item(
            icon: Icons.shopping_cart,
            text: 'Cart',
            // ignore: avoid_print
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              ),
            },
          ),
          _item(
              icon: Icons.category,
              text: 'Category',
              // ignore: avoid_print
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    ),
                  }),
          _item(
              icon: Icons.favorite,
              text: 'Favorite',
              // ignore: avoid_print
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(foodViewModel: modelView,),
                      ),
                    ),
                  }),

          const Divider(height: 25, thickness: 1),

          _item(
              icon: Icons.outbox,
              text: 'Log out',
              // ignore: avoid_print
              onTap: () => logout()),
          // const Padding(
          //   padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          //   child: Text("Labels",
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.blue,
          //       )),
          // ),
        ],
      ),
    );
  }

  logout() async {
    final modelView = Provider.of<UserViewModel>(context, listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("login");
      preferences.remove("username");
      preferences.remove('email');
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(
          onCreate: (user) {
            preferences.clear();
            modelView.addUser(user);
            Navigator.pop(context);
          },
        ),
      ),
      (route) => false,
    );
  }

  Widget _header() {
    final user = UserPreferences.myUser;
    return UserAccountsDrawerHeader(
      currentAccountPicture: ClipOval(
        child: Image(image: AssetImage('assets/orang1.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text(user.name!),
      accountEmail: Text(user.email),
    );
  }

  Widget _item({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
