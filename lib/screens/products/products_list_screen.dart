import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/screens/orders/single_order.dart';
import 'package:sizer/sizer.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key key}) : super(key: key);
  final images = [
    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
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
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleOrderScreen(),
                  ),
                );
              },
              child: Ink(
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Заказ №0001',
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '25.12.2020  12:00',
                                      style: TextStyle(
                                        fontSize: 10.0.sp,
                                      ),
                                    ),
                                    Text(
                                      'Магазин:\nRosalie',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                    Text(
                                      'Доставка: 10:00',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                    Text(
                                      'Сумма: 10 000 тг.',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.w500,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: GridView.builder(
                                    itemCount: 4,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: w / (h / 1.85),
                                    ),
                                    itemBuilder: (context, index) {
                                      if (images.length > 4) if (index == 3)
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 2),
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
                                              (context, imageProvider) =>
                                                  Center(
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
                                            child: LoaderWidget(),
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
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
