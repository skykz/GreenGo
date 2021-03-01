import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';

class FullImageScreen extends StatefulWidget {
  final List<dynamic> listImages;
  FullImageScreen({Key key, this.listImages}) : super(key: key);

  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  String _currentImage;

  @override
  void initState() {
    _currentImage = this.widget.listImages[0]['src'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppStyle.colorPurple,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InteractiveViewer(
                    child: CachedNetworkImage(
                      imageUrl: _currentImage.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, string) => const Center(
                        child: LoaderWidget(),
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
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: this.widget.listImages.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentImage =
                                this.widget.listImages[index]['src'];
                          });
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              this.widget.listImages[index]['src'].toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, string) => const Center(
                            child: LoaderWidget(),
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
