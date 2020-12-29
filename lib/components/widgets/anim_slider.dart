import 'package:flutter/material.dart';

class AnimSliderWidget extends StatefulWidget {
  final double w;
  final double h;
  AnimSliderWidget({this.h, this.w});

  @override
  _AnimSliderWidgetState createState() => _AnimSliderWidgetState();
}

class _AnimSliderWidgetState extends State<AnimSliderWidget>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  int currentPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = widget.w;
    final padding = (30 * 2) - (10 * 2);
    pageController = PageController(
      initialPage: currentPage,
      viewportFraction: (width - padding) / width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.w,
        height: widget.h * 0.3,
        child: PageView(
          onPageChanged: (index) {
            setState(() => currentPage = index);
          },
          controller: pageController,
          children: <Widget>[
            for (int i = 0; i < 5; i++) buildItem(i),
          ],
        ),
      ),
    );
  }

  Widget buildItem(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
        } else {
          // If haveDimensions is false, use _currentPage to calculate value.
          value = (currentPage - index).toDouble();
        }
        value = (1 - (value.abs() * .5)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Center(
          child: Transform(
            transform: Matrix4.diagonal3Values(1.0, value, 1.0),
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/png/image_demo.png',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
