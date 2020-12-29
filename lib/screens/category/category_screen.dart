import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/long_card_widget.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  final bool isStore;

  const CategoryScreen({Key key, this.isStore = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Text(
                this.isStore ? "Магазин" : "КАТЕГОРИИ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: CardLongWidget(
                      onTap: () {},
                      title: "$index categoryName",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
