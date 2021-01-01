import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/long_card_widget.dart';
import 'package:green_go/components/widgets/single_product.dart';
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
                  return ListStoreCatergoryScreen(
                    isStore: false,
                  );
                case '/storeList':
                  return ListStoreCatergoryScreen(
                    isStore: true,
                  );
                case '/singleStore':
                  return SingleProductWidget();
                default:
                  return ListStoreCatergoryScreen(
                    isStore: false,
                  );
                  break;
              }
            });
      },
    );
  }
}

class ListStoreCatergoryScreen extends StatelessWidget {
  final bool isStore;
  const ListStoreCatergoryScreen({Key key, this.isStore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Text(
                  this.isStore ? 'Магазин' : "КАТЕГОРИИ",
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
                          if (this.isStore)
                            Navigator.pushNamed(context, '/singleStore');
                          else
                            Navigator.pushNamed(context, '/storeList');
                        },
                        title:
                            "$index ${this.isStore ? 'магазины' : 'categoryName'}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
