import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/components/side_menu.dart';
import 'package:chatbot/ChatPage/chat_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final urlImages=[
    'assets/images/img9.jpg',
    'assets/images/img6.jpeg',
    'assets/images/img7.jpg',
    'assets/images/img2.jpg',
    'assets/images/img11.jpg'
  ];
Widget buildImageWithButton(String urlImage, int index) {
  return Stack(
    children: <Widget>[
      // Image Container
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Smooth rounded edges
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Subtle shadow
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            urlImage,
            fit: BoxFit.contain,
            width: double.infinity,
            height: 400, // Match carousel height
          ),
        ),
      ),
      // Beautiful Floating Button
      Positioned(
        right: 20.0,
        top: 20.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration:const BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 53, 86, 63), Color.fromARGB(255, 53, 86, 63)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: const SideMenu(),
    appBar: AppBar(
      title: SizedBox(
        height: 40.0, // Adjust height as needed
        child: Image.asset(
          'assets/images/PngItem_5002858.png',
          fit: BoxFit.contain,
        ),
      ),
    ),
    body: Stack(
      children: [
        // Carousel
        Center(
          child: CarouselSlider.builder(
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = urlImages[index];
              return buildImageWithButton(urlImage, index);
            },
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
          ),
        ),

        // "Chat Now" Button - Fixed at Bottom
        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 53, 86, 63),Color.fromARGB(255, 53, 86, 63)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Chat Now",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}