import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/long_card_widget.dart';
import 'package:green_go/screens/home/single_store_home.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  final bool isStore;

  const CategoryScreen({Key key, this.isStore = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return ListCatergoryScreen(
                    isStore: false,
                  );
                case '/singleCategory':
                  return SingleCategiryStoreHomeScreen();
                default:
                  return ListCatergoryScreen(
                    isStore: false,
                  );
                  break;
              }
            });
      },
    );
  }
}

class ListCatergoryScreen extends StatelessWidget {
  final bool isStore;
  const ListCatergoryScreen({Key key, this.isStore = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Text(
                "КАТЕГОРИИ",
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
                      onTap: () {
                        Navigator.pushNamed(context, '/singleCategory');
                      },
                      title: "$index ${'categoryName'}",
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
