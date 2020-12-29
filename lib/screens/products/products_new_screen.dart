import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

class ProductNewScreen extends StatelessWidget {
  ProductNewScreen({Key key}) : super(key: key);
  final images = [
    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 7,
                        offset: Offset(0, 6),
                      ),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 28.0.h,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Дата создания: 30.12.2020  17:00',
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                    ),
                                  ),
                                  Text(
                                    'Королевские розы',
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Красивые и нежные розочки',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Способ отправки:\n",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10.0.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Самовывоз или Досатвкой",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Цена: 10 000',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Статус: ",
                                      style: TextStyle(
                                        color: AppStyle.colorGreen,
                                        fontSize: 11.0.sp,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Активен",
                                          style: TextStyle(
                                            color: AppStyle.colorGreen,
                                            fontSize: 12.0.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: GridView.builder(
                                  itemCount: 4,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: w / (h / 1.9),
                                  ),
                                  itemBuilder: (context, index) {
                                    if (images.length > 4) if (index == 3)
                                      return Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Icon(
                                            Icons.more_horiz_rounded,
                                            size: 35.0.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    return Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: CachedNetworkImage(
                                        imageUrl: images[index],
                                        imageBuilder:
                                            (context, imageProvider) => Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, string) =>
                                            Center(
                                          child: CustomProgressWidget(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          child: const Center(
                                            child: Icon(
                                              Icons.error_outline_rounded,
                                              color: Colors.red,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 3,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: FlatButton(
                        color: AppStyle.colorGreen,
                        onPressed: () {},
                        splashColor: Colors.green[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ПОТВЕРДИТЬ ПРОДАЖУ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.0.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
