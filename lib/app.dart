import 'package:flutter/material.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/index.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer_util.dart';

import 'core/provider/base_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
          create: (context) => BaseProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: IndexScreen(),
            );
          });
        },
      ),
    );
  }
}
