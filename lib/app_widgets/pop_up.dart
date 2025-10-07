import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const PopUp({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Responsive values
    double imageHeight = screenSize.height * 0.25; // 25% of screen height
    double titleFontSize = screenSize.width * 0.05; // 5% of screen width
    double descFontSize = screenSize.width * 0.04; // 4% of screen width
    double buttonFontSize = screenSize.width * 0.045;
    double buttonOffset = screenSize.height * 0.01; // how far buttons float below
    double reservedSpace = screenSize.height * 0.08; // space inside popup for buttons

    return Dialog(
      insetPadding: EdgeInsets.all(screenSize.width * 0.04), // margin from screen edges
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent, // 👈 transparent behind card
      child: Stack(
        clipBehavior: Clip.none, // allow buttons outside
        children: [
          // 🔼 Popup content
          Container(
            constraints: BoxConstraints(
              maxHeight: screenSize.height * 0.6, // popup max 60% of screen
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(screenSize.width * 0.04),

            child: SingleChildScrollView( // 👈 makes content scrollable
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🖼 Image
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: imageHeight,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.015),

                  // 📝 Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),

                  // 📄 Description
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: descFontSize,
                      color: Colors.grey[700],
                    ),
                  ),

                  // Reserve space so buttons don’t overlap text
                  SizedBox(height: reservedSpace),
                ],
              ),
            ),
          ),

          // 🔽 Floating buttons
          Positioned(
            bottom: -buttonOffset,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.lightbulb_outline),
                  label: Text(
                    "Suggest",
                    style: TextStyle(fontSize: buttonFontSize),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.handshake),
                  label: Text(
                    "Give Service",
                    style: TextStyle(fontSize: buttonFontSize),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}