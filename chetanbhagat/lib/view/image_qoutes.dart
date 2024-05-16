import 'dart:convert';

import 'package:chetan_bhagat/modal/image_qoutes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageQoutesView extends StatefulWidget {
  const ImageQoutesView({Key? key}) : super(key: key);

  @override
  _ImageQoutesViewState createState() => _ImageQoutesViewState();
}

class _ImageQoutesViewState extends State<ImageQoutesView> {
  List<ImageQoutes>? ofImageQoutes;
  void motivationalStories() async {
    try {
      var books = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/chetan_bhagat/image_quotes'));

      if (books.statusCode == 200) {
        ofImageQoutes = ImageQoutes.motivationalStorie(jsonDecode(books.body));
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
          "Motivational Quotes",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: ofImageQoutes == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider();
                },
                padding: EdgeInsets.all(16),
                itemCount: ofImageQoutes!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child:
                        Image.network(ofImageQoutes![index].image.toString()),
                  );
                }),
      ),
    );
  }
}
