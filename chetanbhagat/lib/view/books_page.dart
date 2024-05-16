import 'dart:convert';

import 'package:chetan_bhagat/modal/books_modal.dart';
import 'package:chetan_bhagat/view/buyBooksLink.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<BooksModal>? chetanBhagatBooks;
  void getbooks() async {
    try {
      var books = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/chetan_bhagat/book_link'));

      if (books.statusCode == 200) {
        chetanBhagatBooks = BooksModal.ofBooks(jsonDecode(books.body));
      } else {
        print("Something went Wrong");
      }

      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    getbooks();
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
          "BOOKS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: chetanBhagatBooks == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: GridView.builder(
                    itemCount: chetanBhagatBooks!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyBooksLink(
                                        url: chetanBhagatBooks![index]
                                            .bookLinkUrl,
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    chetanBhagatBooks![index]
                                        .bookLinkImage
                                        .toString(),
                                  ))),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            width: double.infinity,
                            child: Container(
                                height: 40,
                                color: Colors.black38,
                                width: double.infinity,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  chetanBhagatBooks![index]
                                      .bookLinkName
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
