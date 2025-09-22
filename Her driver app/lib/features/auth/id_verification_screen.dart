import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdVerificationScreen extends StatefulWidget {
  @override
  _IdVerificationScreenState createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  File? _idDocument;
  File? _selfie;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _idNumberController = TextEditingController();

  Future<void> _pickIdDocument() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _idDocument = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickSelfie() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selfie = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImages() async {
    if (_idDocument == null || _selfie == null) {
      Get.snackbar('Error', 'Please select both an ID document and a selfie.');
      return;
    }

    final ApiClient apiClient = Get.find<ApiClient>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(AppConstants.token);

    if (token == null) {
      Get.snackbar('Error', 'You are not logged in.');
      return;
    }

    final List<MultipartBody> multipartBody = [
      MultipartBody('id_document', _idDocument!),
      MultipartBody('selfie', _selfie!),
    ];

    final Map<String, String> fields = {
      'identification_number': _idNumberController.text,
    };

    final Response response = await apiClient.postMultipartData(
      AppConstants.identityVerificationUpload,
      multipartBody,
      fields,
    );

    if (response.statusCode == 200) {
      prefs.setBool('is_verified', true);
      Get.snackbar('Success', 'Images uploaded successfully.');
    } else {
      Get.snackbar('Error', 'Failed to upload images.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ID Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idNumberController,
              decoration: InputDecoration(labelText: 'ID Number'),
            ),
            SizedBox(height: 20),
            if (_idDocument != null) Image.file(_idDocument!),
            ElevatedButton(
              onPressed: _pickIdDocument,
              child: Text('Pick ID Document'),
            ),
            SizedBox(height: 20),
            if (_selfie != null) Image.file(_selfie!),
            ElevatedButton(
              onPressed: _pickSelfie,
              child: Text('Take Selfie'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImages,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
