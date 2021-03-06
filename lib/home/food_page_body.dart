import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/utils/colors.dart';
import 'package:flutter_commerce/utils/dimensions.dart';
import 'package:flutter_commerce/widgets/big_text.dart';
import 'package:flutter_commerce/widgets/icon_and_text_widget.dart';
import 'package:flutter_commerce/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageView(220);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print('Current value is ${_currPageValue.toString()}');

      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.pageView(320),
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.pageView(30)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 1);
    }

    return Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageView(220),
              margin: EdgeInsets.only(left: Dimensions.pageView(10), right: Dimensions.pageView(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.pageView(30)),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/image/food1.png'
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageView(120),
                margin: EdgeInsets.only(left: Dimensions.pageView(30), right: Dimensions.pageView(30), bottom: Dimensions.pageView(30)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.pageView(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(5, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.pageView(15), left: Dimensions.pageView(15), right: Dimensions.pageView(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Chinese Side'),
                      SizedBox(height: Dimensions.pageView(10),),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(Icons.star, color: AppColors.mainColor, size: 15,);
                            }),
                          ),
                          SizedBox(width: Dimensions.pageView(10),),
                          SmallText(text: '4.5'),
                          SizedBox(width: Dimensions.pageView(10),),
                          SmallText(text: '1287'),
                          SizedBox(width: Dimensions.pageView(10),),
                          SmallText(text: 'comments'),
                        ],
                      ),
                      SizedBox(height: Dimensions.pageView(20),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                              icon: Icons.circle_sharp,
                              text: 'Normal',
                              iconColor: AppColors.iconColor1
                          ),
                          IconAndTextWidget(
                              icon: Icons.location_on,
                              text: '1.7km',
                              iconColor: AppColors.mainColor
                          ),
                          IconAndTextWidget(
                              icon: Icons.access_time_rounded,
                              text: '32min',
                              iconColor: AppColors.iconColor2
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
