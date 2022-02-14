import 'package:flutter/material.dart';
import 'package:flutter_commerce/home/food_page_body.dart';
import 'package:flutter_commerce/utils/colors.dart';
import 'package:flutter_commerce/widgets/big_text.dart';
import 'package:flutter_commerce/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print('curent height is ${MediaQuery.of(context).size.height.toString()}');
    return Scaffold(
      body: Column(
        children: [
          //showing the header
          Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Bangladesh', color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text: 'Narsingdi', color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded, color: Colors.black54)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.search, color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //showing the body
          FoodPageBody(),
        ],
      )
    );
  }
}
