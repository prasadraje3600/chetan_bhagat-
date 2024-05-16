import 'dart:convert';

import 'package:chetan_bhagat/modal/motivation_stories_modal.dart';
import 'package:expandable/expandable.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MotivationalStoriesList extends StatefulWidget {
  MotivationalStoriesList({Key? key}) : super(key: key);

  @override
  _MotivationalStoriesListState createState() =>
      _MotivationalStoriesListState();
}

class _MotivationalStoriesListState extends State<MotivationalStoriesList> {
  List<MotivationalStories>? ofStories;
  void motivationalStories() async {
    try {
      var books = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/chetan_bhagat/text_stories'));

      if (books.statusCode == 200) {
        ofStories =
            MotivationalStories.motivationalStorie(jsonDecode(books.body));
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
          title: const Text(
            "STORIES",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ofStories == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, i) {
                      return const Divider();
                    },
                    itemCount: ofStories!.length,
                    padding: const EdgeInsets.all(14),
                    itemBuilder: ((context, index) {
                      return ExpansionTileCard(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF021C4F),
                          child: Icon(
                            Icons.book_rounded,
                            color: Colors.amber,
                          ),
                        ),
                        title: Text(
                          ofStories![index].title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF021C4F)),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Title(
                                color: Colors.black,
                                child: Text(
                                  ofStories![index].textStories ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      );
                    }))));
  }
}
