import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/custom_loader.dart';
import 'package:green_go/components/widgets/single_product.dart';
import 'package:sizer/sizer.dart';

class SingleHomeScreen extends StatefulWidget {
  const SingleHomeScreen({Key key}) : super(key: key);

  @override
  _SingleHomeScreenState createState() => _SingleHomeScreenState();
}

class _SingleHomeScreenState extends State<SingleHomeScreen> {
  ScrollController _scrollController;
  var currentSelectedValue;
  var deviceTypes = ["Mac", "Windows", "Mobile"];
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleProductWidget(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              'ТОВАРЫ МАГАЗИНА',
              style: TextStyle(
                fontSize: 13.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  'Топ товаров',
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 29.0.h,
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {},
                                child: Ink(
                                  width: 45.0.w,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          offset: Offset(0, 5),
                                          spreadRadius: 1,
                                          color: Colors.grey[300],
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                        imageBuilder:
                                            (context, imageProvider) => Center(
                                          child: Container(
                                            width: 21.0.w,
                                            height: 11.0.h,
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
                                      Flexible(
                                        child: Center(
                                          child: Text(
                                            'Королевский свадебный',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.5.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Цена: 30 000',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.5.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_outline_rounded,
                                  color: AppStyle.colorPurple,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: AppStyle.colorGreen,
                        ),
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.offset - 200,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppStyle.colorGreen,
                        ),
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.offset + 200,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SizedBox(
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Выберите"),
                      value: currentSelectedValue,
                      isExpanded: true,
                      focusColor: AppStyle.colorPurple,
                      icon: SvgPicture.asset('assets/images/svg/menu.svg'),
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          currentSelectedValue = newValue;
                        });
                        print(currentSelectedValue);
                      },
                      items: deviceTypes.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 10.0.h,
            child: ListView.builder(
              itemCount: 15,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: FlatButton(
                      color: AppStyle.colorGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {},
                      child: Text(
                        '$index sdsdfsf',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/grid.svg',
                    color: Colors.black,
                    width: 20.0.sp,
                  ),
                  onPressed: () {}),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/svg/list.svg',
                  color: Colors.black,
                  width: 20.0.sp,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 20, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ВИТРИНА ТОВАРОВ',
                style: TextStyle(
                  fontSize: 11.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GridView.builder(
            itemCount: 12,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),
            ),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                offset: Offset(0, 5),
                                spreadRadius: 1,
                                color: Colors.grey[300],
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                              imageBuilder: (context, imageProvider) => Center(
                                child: Container(
                                  width: 19.0.w,
                                  height: 10.0.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, string) => Center(
                                child: CustomProgressWidget(
                                  color: Colors.grey,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(child: Text("data[index]")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: 3,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_outline_rounded,
                        color: AppStyle.colorPurple,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              );
            },
          ),
          SizedBox(
            height: 5.0.h,
          ),
        ],
      ),
    );
  }
}
