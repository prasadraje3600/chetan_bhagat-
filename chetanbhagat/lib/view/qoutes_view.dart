import 'dart:convert';

import 'package:chetan_bhagat/modal/qoutes_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<QuotesModal>? chetanBhagatQuotes;
  void getquotes() async {
    try {
      var quotes = await http.post(Uri.parse(
          'https://mapi.trycatchtech.com/v3/chetan_bhagat/text_quotes'));

      if (quotes.statusCode == 200) {
        chetanBhagatQuotes = QuotesModal.ofquotes(jsonDecode(quotes.body));
      } else {
        print("Something went Wrong");
      }

      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    getquotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF021C4F),
          title: const Text(
            "Quotes",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: chetanBhagatQuotes == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: chetanBhagatQuotes!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      splashColor: const Color.fromARGB(255, 5, 90, 130),
                      tileColor: const Color.fromARGB(255, 229, 238, 131),
                      title: Text(
                        chetanBhagatQuotes![index].textQuote ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                          child: Text(
                        chetanBhagatQuotes![index].id ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  );
                }));
  }
}
