import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';

class CategoryItemCardWidget extends StatelessWidget {
  CategoryItemCardWidget(
      {Key? key, required this.item, this.color = Colors.red})
      : super(key: key);
  final Food item;

  final height = 200.0;

  final width = 175.0;

  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Card(
              child: Stack(
                children: [
                      Container(
                        alignment: Alignment.topRight,
                        height: 120,
                        width: 120,
                        child: imageWidget(),
                      ),
                  Expanded(
                    // height: 60,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Flexible(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),        
    );
  }

  Widget imageWidget() {
    return Image.network(
      item.image,
      fit: BoxFit.fill,
    );
  }
}
