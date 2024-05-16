import 'dart:convert';

import 'package:chetan_bhagat/modal/video_player_modal.dart';
import 'package:chetan_bhagat/view/play_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class VideoPlayerTitle extends StatefulWidget {
  const VideoPlayerTitle({Key? key}) : super(key: key);

  @override
  _VideoPlayerTitleState createState() => _VideoPlayerTitleState();
}

class _VideoPlayerTitleState extends State<VideoPlayerTitle> {
  List<VideoStories>? videoStories;
  void motivationalStories() async {
    try {
      var books = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/chetan_bhagat/video_stories'));

      if (books.statusCode == 200) {
        videoStories = VideoStories.videoStorie(jsonDecode(books.body));
      } else {
        print("Something went Wrong");
      }

      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    motivationalStories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF021C4F),
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF021C4F),
          title: Text(
            "Video List",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: videoStories == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                      separatorBuilder: (context, i) {
                        return Divider();
                      },
                      itemCount: videoStories!.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayVideo(
                                          stories: videoStories![i],
                                        )));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    videoStories![i].title!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ));
  }
}
