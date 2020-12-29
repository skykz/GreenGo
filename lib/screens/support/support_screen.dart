import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/expansion_widget.dart';
import 'package:sizer/sizer.dart';

class SupportScreen extends StatefulWidget {
  SupportScreen({Key key}) : super(key: key);

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "ПОМОЩЬ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Часто задаваемые вопросы',
              style: TextStyle(
                color: AppStyle.colorPurple,
                fontSize: 13.0.sp,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return AppExpansionTile(
                  initiallyExpanded: false,
                  leading: Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: this._isSelected == index
                          ? Colors.black
                          : AppStyle.colorPurple,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  iconData: Icons.arrow_back_ios_rounded,
                  onExpansionChanged: (val) {
                    setState(() {
                      this._isSelected = index;
                    });
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(' Что делать, если цветы прислали завядшие'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          "1. Налейте в вазу прохладную воду.2. Снимите со стеблей нижние листья, освежите срезы растений под проточной водой острым ножом под углом 45°C. 3. Меняйте воду ежедневно, стебли нужно обмывать под проточной водой и регулярно обновлять срезы, несколько раз в день букет следует опрыскивать из пульверизатора."),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
