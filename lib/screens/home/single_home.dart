import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/custom_loader.dart';
import 'package:green_go/screens/home/single_product.dart';
import 'package:green_go/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SingleHomeScreen extends StatefulWidget {
  const SingleHomeScreen({Key key}) : super(key: key);

  @override
  _SingleHomeScreenState createState() => _SingleHomeScreenState();
}

class _SingleHomeScreenState extends State<SingleHomeScreen> {
  int _selectedCategoryIndex = 0;
  ScrollController _scrollController;
  String currentSelectedValue;
  bool _isSquareType = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 25.0.sp,
            color: Colors.purple[400],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SingleProductWidget(),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                              (context, imageProvider) =>
                                                  Center(
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

            SizedBox(
              height: 10.0.h,
              child: ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: FlatButton(
                        color: this._selectedCategoryIndex == index
                            ? Colors.white
                            : AppStyle.colorGreen,
                        shape: RoundedRectangleBorder(
                          side: this._selectedCategoryIndex == index
                              ? BorderSide(
                                  color: Colors.purple,
                                  width: 1,
                                )
                              : BorderSide(
                                  color: AppStyle.colorGreen,
                                  width: 1,
                                ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Text(
                          '$index sdsdfsf',
                          style: TextStyle(
                            color: this._selectedCategoryIndex == index
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Сортировка"),
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
                      items: sortTypes.map((String value) {
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

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/svg/grid.svg',
                      color:
                          _isSquareType ? AppStyle.colorPurple : Colors.black,
                      width: 20.0.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSquareType = true;
                      });
                    }),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/list.svg',
                    color: !_isSquareType ? AppStyle.colorPurple : Colors.black,
                    width: 20.0.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSquareType = false;
                    });
                  },
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
            this._isSquareType
                ? GridView.builder(
                    itemCount: 12,
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleProductScreen(),
                                  ),
                                );
                              },
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                      imageBuilder: (context, imageProvider) =>
                                          Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
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
                                      placeholder: (context, string) => Center(
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
                  )
                : ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Stack(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleProductScreen(),
                                  ),
                                );
                              },
                              child: Ink(
                                width: double.infinity,
                                height: 20.0.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 10,
                                      offset: Offset(0, 7),
                                      spreadRadius: 1,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                        imageBuilder:
                                            (context, imageProvider) => Center(
                                          child: Container(
                                            width: 80,
                                            height: 80,
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
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Букет с гортензией',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0.sp,
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Магазин:\n',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10.0.sp,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'Rosalie',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13.0.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Рейтинг:',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10.0.sp,
                                                    ),
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: 3.5,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star_rounded,
                                                      color:
                                                          AppStyle.colorPurple,
                                                    ),
                                                    itemCount: 5,
                                                    unratedColor:
                                                        Colors.grey[300],
                                                    itemSize: 13.0.sp,
                                                    direction: Axis.horizontal,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Цена 13 000',
                                              style: TextStyle(
                                                fontSize: 11.0.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  color: AppStyle.colorPurple,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
