import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_store_home.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:green_go/components/widgets/long_card_widget.dart';

class StoreCategory extends StatelessWidget {
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
                case '/singleStore':
                  return SingleCategiryStoreHomeScreen(
                    isStore: true,
                  );
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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Text(
                "Магазины",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                ),
              ),
            ),
          ),
          Consumer<HomeProvider>(builder: (context, provider, child) {
            return Expanded(
              child: FutureBuilder(
                  future: provider.getStoresList(context),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                      return Center(child: const LoaderWidget());
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: CardLongWidget(
                              onTap: () {
                                Navigator.pushNamed(context, '/singleStore',
                                    arguments: snapshot.data['data'][index]);
                              },
                              title: "${snapshot.data['data'][index]['title']}",
                            ),
                          ),
                        );
                      },
                    );
                  }),
            );
          }),
        ],
      ),
    );
  }
}
