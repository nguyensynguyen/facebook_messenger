import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
@immutable
class NewsDetail extends StatefulWidget {
  @override
  String img = '';
  String userAvatar;

  NewsDetail({this.img,this.userAvatar});

  _DetailNews createState() => _DetailNews();
}

class _DetailNews extends State<NewsDetail> {
  PaletteGenerator Gen;
  Color getColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    if (FAProgressBar().animatedDuration.inMilliseconds == 500) {

    }
    _updatePalte();
    print(widget.img);
  }

  _updatePalte() async {
    Gen = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.img),size: Size(200,200)
    );
    setState(() {
      getColor = Gen.lightMutedColor.color.withOpacity(0.9);
    });
  }

  _onLoading() {
    new Future.delayed(new Duration(milliseconds: 8500), () {

      Navigator.pop(context); //pop dialog
    });
    return Padding(
      child: Container(
          child: FAProgressBar(
            currentValue: 100,
            size: 3,
            progressColor: Colors.white.withOpacity(0.8),
            backgroundColor: Colors.white70.withOpacity(0.2),
            animatedDuration: const Duration(seconds: 8),
          )),
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _onLoading(),
                    Container(
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                                radius: 22.0,
                                backgroundImage: NetworkImage(
                                  widget.userAvatar,
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[Text('User'), Text('19:09')],
                              ),
                            ),
                          ),
                          Icon(Icons.more_vert,size: 30,color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context); //pop dialog
                              },
                              child: Icon(Icons.close,size: 30,color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 48.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              new BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(color: Colors.white, width: 1.4)),
                          width: 200.0,
                          height: 40.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập tin nhắn',
                                    contentPadding: EdgeInsets.only(
                                        left: 15, bottom: 13, right: 15),
                                    focusColor: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                            onTap: _updatePalte,
                            child: Icon(
                              FlatIcons.add,
                              size: 32.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.more,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.more,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.more,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.more,
                            size: 32.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.more,
                            size: 32.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
