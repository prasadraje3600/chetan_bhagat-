import 'package:chetan_bhagat/modal/home_modal.dart';
import 'package:chetan_bhagat/view/books_page.dart';
import 'package:chetan_bhagat/view/image_qoutes.dart';
import 'package:chetan_bhagat/view/login.dart';
import 'package:chetan_bhagat/view/motivational_stories.dart';
import 'package:chetan_bhagat/view/qoutes_view.dart';
import 'package:chetan_bhagat/view/video_player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    List<HomeModal> dashboard = [
      HomeModal(
          image: 'images/books_1.png',
          title: "Books",
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BooksPage()));
          }),
      HomeModal(
          image: 'images/MOTIVATIONAL.png',
          title: "Motivational\nStories",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MotivationalStoriesList()));
          }),
      HomeModal(
          image: 'images/Quotes.png',
          title: "Quotes",
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => QuotesPage()));
          }),
      HomeModal(
          image: 'images/images.png',
          title: 'Images',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImageQoutesView()));
          }),
      HomeModal(
          image: 'images/VIDEOS.png',
          title: 'Videos',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoPlayerTitle()));
          }),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF021C4F),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              SharedPreferences clear = await SharedPreferences.getInstance();

              clear.clear();
              setState(() {});

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon: Icon(Icons.logout)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF021C4F),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 30.0,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: dashboard.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    dashboard[index].onTap();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        dashboard[index].image,
                        // width: 160,
                        // height: 120,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        dashboard[index].title,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
