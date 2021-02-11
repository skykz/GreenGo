import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/components/widgets/long_card_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_store_category.dart';
import 'package:provider/provider.dart';
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
                  return SingleCategoryStoreHomeScreen();
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
    dynamic selfArgument = ModalRoute.of(context).settings.arguments;
    inspect(selfArgument);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                selfArgument == null ? "КАТЕГОРИИ" : "ПОДКАТЕГОРИИ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0.sp,
                ),
              ),
            ),
          ),
          Consumer<HomeProvider>(builder: (context, provider, _) {
            return FutureBuilder(
                future: provider.getCatalogsProducts(
                    context,
                    selfArgument == null ? true : false,
                    selfArgument != null ? selfArgument['id'] : null),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null)
                    return const Center(
                      child: LoaderWidget(),
                    );
                  inspect(snapshot.data['data']);
                  return Expanded(
                    child: Center(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length + 1,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == snapshot.data['data'].length)
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: CardLongWidget(
                                onTap: () {
                                  final homeProvider =
                                      Provider.of<HomeProvider>(context,
                                          listen: false);

                                  if (selfArgument != null)
                                    Navigator.pushNamed(
                                        context, '/singleCategory',
                                        arguments: selfArgument);
                                  else
                                    homeProvider.setSelectedIndex(0);
                                },
                                title: selfArgument == null
                                    ? 'Все категории'
                                    : 'Все подкатегории',
                              ),
                            );
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: CardLongWidget(
                                onTap: () {
                                  if (selfArgument == null) {
                                    if (snapshot.data['data'][index]
                                        ['isParent']) {
                                      Navigator.pushReplacementNamed(
                                          context, '/',
                                          arguments: snapshot.data['data']
                                              [index]);
                                    }
                                  } else {
                                    Navigator.pushNamed(
                                        context, '/singleCategory',
                                        arguments: snapshot.data['data']
                                            [index]);
                                  }
                                },
                                title: snapshot.data['data'][index]['title'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }
}
