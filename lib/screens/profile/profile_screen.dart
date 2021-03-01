import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PickedFile _imageFile;
  List<int> _imageIds = List();

  bool isChecked = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Builder(
                  builder: (ctx) => InkWell(
                    onTap: () =>
                        _onImageButtonPressed(ImageSource.gallery, ctx),
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              offset: Offset(0, 7),
                              color: Colors.grey[300],
                            ),
                          ]),
                      child: _imageFile == null
                          ? SvgPicture.asset(
                              'assets/images/svg/profile_image.svg',
                              height: 16.0.h,
                            )
                          : SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_imageFile.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Ваше фото',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ф.И.О.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Телефон',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'E-mail',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        // Icon(
                        //   Icons.edit_outlined,
                        //   color: Colors.black,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: AppStyle.colorGreen,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  highlightColor: Colors.grey[300],
                  highlightedBorderColor: Colors.green,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Text(
                      ' Сохранить ',
                      style: TextStyle(
                        fontSize: 10.0.sp,
                        color: AppStyle.colorGreen,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, BuildContext ctx) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    final _pickedFile = await _picker.getImage(
      source: source,
      imageQuality: 80,
    );

    homeProvider.uploadImageItem(File(_pickedFile.path), context).then((value) {
      if (value != null) {
        _imageIds.add(value['data']['id']);
      }
    });
    if (_pickedFile != null) {
      setState(() {
        _imageFile = _pickedFile;
      });
    } else {
      showCustomSnackBar(
        ctx,
        'Изображение не выбрано!',
        Colors.red,
        Icons.error_outline_rounded,
      );
    }
  }
}
