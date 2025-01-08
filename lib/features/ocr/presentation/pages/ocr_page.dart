import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:habit_app/core/constants/app_colors.dart';
import 'package:habit_app/core/custom_widgets/Appbar_widget.dart';
import 'package:habit_app/core/custom_widgets/app_button.dart';
import 'package:habit_app/core/custom_widgets/color_picker_widget.dart';
import 'package:habit_app/core/custom_widgets/custom_dialog.dart';
import 'package:habit_app/core/custom_widgets/floating_button.dart';
import 'package:habit_app/features/ocr/domain/ocr_service.dart';
import 'package:image_picker/image_picker.dart';

class OcrPage extends StatefulWidget {
  OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  // ImagePicker for selecting images
  final ImagePicker _picker = ImagePicker();

  // Default selected color for OCR note
  Color _selectedColor = AppColors.choiceColor1;

  // File to store the selected image
  File? _selectedImage;

  // String to store recognized text from the image
  String? _recognizedText;

  // TextRecognizer for OCR processing
  final textRecognizer = TextRecognizer();

  // Function to save recognized text as an OCR note
  Future<void> saveOCRNote() async {
    if (_recognizedText != null) {
      // Save the OCR note using a service class
      await OCRService().addOCRNote(_recognizedText!, _selectedColor.value);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OCR Text Saved')),
      );
    } else {
      // Show an error message if no text is recognized
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No text to save')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppbarWidget(
            backgroundColor: AppColors.whiteColor,
            title: const Text(
              'Image to Text',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  // Open the color picker dialog and save the note after selecting a color
                  await colourPicker(context);
                  saveOCRNote();
                },
                icon: const Icon(Icons.save_alt_outlined),
              )
            ],
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      // Container to display the selected image
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                      width: width,
                                    ),
                                  )
                                : SizedBox(
                                    width: 140,
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'Upload an image using the “+” button',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      // Container to display the recognized text
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: _recognizedText != null
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25.0, horizontal: 10),
                                        child: Container(
                                          width: width,
                                          child: Text(
                                            _recognizedText!,
                                            style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 100, maxWidth: 250),
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'Click the “Scan Image” button to perform scan',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Row(
                          children: [
                            // Button to clear the selected image
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                              style: ButtonStyle(
                                  fixedSize: WidgetStatePropertyAll(
                                      Size(width * 0.30, 30)),
                                  maximumSize: WidgetStatePropertyAll(
                                      Size(width * 0.30, 30)),
                                  minimumSize: WidgetStatePropertyAll(
                                      Size(width * 0.30, 30))),
                              child: Text(
                                'Clear Image',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: AppColors.blackColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Button to scan the selected image for text
                            AppButton(
                              onTap: _processImage,
                              heightx: 30,
                              fontSize: 13,
                              widthx: width * 0.30,
                              buttonText: 'Scan Image',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingButtonWidget(
            onTap: () => imagePickerDialog(
                context), // Button to open image picker dialog
          ),
        ),
      ),
    );
  }

  // Function to process the selected image and extract text using OCR
  Future<void> _processImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    final inputImage = InputImage.fromFile(_selectedImage!);

    try {
      // Process the image and extract recognized text
      final recognizedText = await textRecognizer.processImage(inputImage);
      setState(() {
        _recognizedText = recognizedText.text;
      });
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      textRecognizer.close();
    }
  }

  // Function to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Dialog to allow the user to pick an image from camera or gallery
  void imagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MyCustomDialog(
        option1text: 'Take photo',
        option2text: 'Choose from gallery',
        option1Icon: 'assets/icons/photo_camera_icon.png',
        option2Icon: 'assets/icons/photo_icon.png',
        title: 'New',
        onTap1: () {
          Navigator.of(context).pop();
          _pickImage(ImageSource.camera);
        },
        onTap2: () {
          Navigator.of(context).pop();
          _pickImage(ImageSource.gallery);
        },
      ),
    );
  }

  // Dialog to pick a color for the OCR note
  Future<void> colourPicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => ColourPickerWidget(
        onColorSelected: (color) {
          setState(() {
            _selectedColor = color;
          });
        },
      ),
    );
  }
}
