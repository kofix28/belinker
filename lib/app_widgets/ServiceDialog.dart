import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:map_location_picker/map_location_picker.dart';

class ServiceDialog {
  static void show(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final dialogWidth = screenWidth * 0.9;

    final serviceNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final locationController = TextEditingController();
    final timeController = TextEditingController();

    File? selectedImage;

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: dialogWidth),
        child: SizedBox(
          height: screenHeight * 0.7,
          child: StatefulBuilder(
            builder: (context, setState) {
              LatLng? pickedLocation;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Add Your Service",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ اسم الخدمة
                    TextField(
                      controller: serviceNameController,
                      decoration: InputDecoration(
                        labelText: "Service Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ الوصف
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ السعر
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ رفع صورة
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Service Image",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.photo),
                              label: const Text("Gallery"),
                              onPressed: () async {
                                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if (picked != null) {
                                  setState(() {
                                    selectedImage = File(picked.path);
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.camera_alt),
                              label: const Text("Camera"),
                              onPressed: () async {
                                final picked = await ImagePicker().pickImage(source: ImageSource.camera);
                                if (picked != null) {
                                  setState(() {
                                    selectedImage = File(picked.path);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        if (selectedImage != null) ...[
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              selectedImage!,
                              height: screenHeight * 0.2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ]
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ زر اختيار الموقع
                    ElevatedButton.icon(
                      icon: const Icon(Icons.location_on),
                      label: Text(
                        pickedLocation == null
                            ? "Pick Location"
                            : "Picked: ${pickedLocation.latitude.toStringAsFixed(4)}, ${pickedLocation.longitude.toStringAsFixed(4)}",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapLocationPicker(
                              config: MapLocationPickerConfig(
                                apiKey: "YOUR_API_KEY",
                                initialPosition: const LatLng(31.9539, 35.9106),
                                initialZoom: 14,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                onNext: (geoResult) {
                                  Navigator.pop(context, geoResult);
                                },
                              ),
                              searchConfig: SearchConfig(
                                apiKey: "YOUR_API_KEY",
                                searchHintText: "...ابحث عن موقع",
                              ),
                              geoCodingConfig: GeoCodingConfig(
                                apiKey: "YOUR_API_KEY",
                                language: "en",
                              ),
                            ),
                          ),
                        );

                        if (result != null && result.latLng != null) {
                          setState(() {
                            pickedLocation = result.latLng;
                            locationController.text =
                            "${pickedLocation!.latitude}, ${pickedLocation!.longitude}";
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: locationController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Selected Location",
                        prefixIcon: const Icon(Icons.map),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // ✅ الوقت
                    TextField(
                      controller: timeController,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            timeController.text = picked.toString().split(" ")[0];
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Available Date",
                        prefixIcon: const Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // ✅ زر إرسال
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        debugPrint("Service Name: ${serviceNameController.text}");
                        debugPrint("Description: ${descriptionController.text}");
                        debugPrint("Price: ${priceController.text}");
                        debugPrint("Time: ${timeController.text}");
                        debugPrint("Location: ${locationController.text}");
                        debugPrint("Image: ${selectedImage?.path}");
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ).show();
  }
}
