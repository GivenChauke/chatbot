import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/components/side_menu.dart';

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
  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        child: Image.asset(
          urlImage,
          fit: BoxFit.contain
        ),
      ),
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
      body:Center(
        child: CarouselSlider.builder(
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildImage(urlImage, index);
          },
            options:CarouselOptions(
            height: 400,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height
          ),
        ),
      )
    );
  }
}
