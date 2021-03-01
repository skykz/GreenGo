import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key key}) : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _textProductTextController = TextEditingController();
  final _textCostTextController = TextEditingController();
  final _textDescriptionTextController = TextEditingController();

  List<PickedFile> _imageFile = List();
  List<int> _imageIds = List();

  bool isChecked = false;
  final ImagePicker _picker = ImagePicker();
  bool _isPickup = false;
  bool _isDelivery = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Builder(
                  builder: (ctx) => InkWell(
                    onTap: () => _onImageButtonPressed(ImageSource.camera, ctx),
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      height: 25.0.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 10,
                              offset: Offset(0, 7),
                            )
                          ]),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                                size: 30.0.sp,
                              ),
                            ),
                            Text(
                              'Добавьте изображения',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              this._imageFile.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 20.0.h,
                      child: ListView.builder(
                        itemCount: this._imageFile.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(_imageFile[index].path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: Colors.purple,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2,
                        controller: _textProductTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Название товара',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 4,
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: Colors.purple,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2,
                        controller: _textCostTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Цена',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 4,
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: Colors.purple,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2,
                        controller: _textDescriptionTextController,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Описание',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 4,
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey[300],
                              offset: Offset(0, 7),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                'Способ доставки',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0.sp,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: _isPickup,
                                    onChanged: (v) {
                                      setState(() {
                                        _isPickup = v;
                                      });
                                    }),
                                const Text("Самовывозом"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: _isDelivery,
                                    onChanged: (v) {
                                      setState(() {
                                        _isDelivery = v;
                                      });
                                    }),
                                const Text("Возможна доставка"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              OutlineButton(
                highlightColor: Colors.purple[100],
                padding: const EdgeInsets.all(5),
                highlightedBorderColor: Colors.purple,
                borderSide: BorderSide(
                  color: AppStyle.colorPurple,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: AppStyle.colorPurple,
                      fontSize: 11.0.sp,
                    ),
                  ),
                ),
                onPressed: () {
                  createOrderUser(
                      int.tryParse(_textCostTextController.text),
                      _textProductTextController.text,
                      _textDescriptionTextController.text,
                      _isPickup,
                      _isDelivery,
                      _imageIds,
                      context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, BuildContext ctx) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (_imageFile.length <= 4) {
      final _pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 80,
      );
      // inspect(_pickedFile);
      homeProvider
          .uploadImageItem(File(_pickedFile.path), context)
          .then((value) {
        if (value != null) {
          _imageIds.add(value['data']['id']);
        }
      });
      if (_pickedFile != null) {
        setState(() {
          _imageFile.add(_pickedFile);
        });
      } else {
        showCustomSnackBar(
          ctx,
          'Изображение не выбрано!',
          Colors.red,
          Icons.error_outline_rounded,
        );
      }
    } else {
      showCustomSnackBar(
        ctx,
        'Можно выбрать максимум 5 изображений',
        Colors.red,
        Icons.cancel_rounded,
      );
    }
  }

  void createOrderUser(int cost, String _title, String _desc, bool canPickup,
      bool canDeliver, List<int> _imageId, BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (cost != null &&
        _title.isNotEmpty &&
        _desc.isNotEmpty &&
        _imageId.isNotEmpty) {
      homeProvider.createProduct(
          cost, _title, _desc, canPickup, canDeliver, _imageId, context);
    } else {
      showCustomSnackBar(
        context,
        'Заполните все поля!',
        Colors.red,
        Icons.cancel_rounded,
      );
    }
  }
}
