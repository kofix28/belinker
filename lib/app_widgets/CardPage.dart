import 'package:flutter/material.dart';
import 'pop_up.dart';

class Cardpage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const Cardpage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description
  }
      );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardHeight = MediaQuery.of(context).size.height * 0.3;
    double paddingValue = screenSize.width * 0.04;
    double fontSize = screenSize.width * 0.05;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PopUp(title: title, imageUrl: imageUrl,description: description),
        );
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.017,
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias, // 👈 makes the image corners rounded
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🖼 Image part
              SizedBox(
                height: cardHeight * 0.7, // 70% image
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // 📝 Text part
              Padding(
                padding:  EdgeInsets.all(paddingValue),
                child: Text(
                  title,
                  style:  TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}