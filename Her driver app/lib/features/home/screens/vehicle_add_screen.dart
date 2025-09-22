import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/profile/domain/models/profile_model.dart';
import 'package:her_driver_app/features/splash/controllers/splash_controller.dart';
import 'package:her_driver_app/helper/display_helper.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/features/profile/domain/models/categoty_model.dart';
import 'package:her_driver_app/features/profile/domain/models/vehicle_brand_model.dart';
import 'package:her_driver_app/features/profile/domain/models/vehicle_body.dart';
import 'package:her_driver_app/common_widgets/app_bar_widget.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';
import 'package:her_driver_app/common_widgets/date_picker_widget.dart';
import 'package:her_driver_app/common_widgets/color_picker.dart';

class VehicleAddScreen extends StatefulWidget {
  final Vehicle? vehicleInfo;
  const VehicleAddScreen({super.key, this.vehicleInfo});

  @override
  State<VehicleAddScreen> createState() => _VehicleAddScreenState();
}

class _VehicleAddScreenState extends State<VehicleAddScreen> {
  int _currentStep = 0;
  final List<Step> _steps = [];
  TextEditingController licencePlateNumberController = TextEditingController();
  TextEditingController yearOfManufactureController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController seatingCapacityController = TextEditingController();
  TextEditingController cargoCapacityController = TextEditingController();
  TextEditingController parcelWeightCapacity = TextEditingController();
  TextEditingController loadCapacityController = TextEditingController();

  Color? selectedColor;
  bool isBabySeatAvailable = false;
  bool isHelmetRequired = false;
  List<String> selectedServiceTypes = [];
  List<PlatformFile> documentFiles = [];
  List<String> uploadedDocumentStatus = [];
  List<PlatformFile> vehiclePhotoFiles = [];

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getVehicleBrandList(1);
    Get.find<ProfileController>().clearVehicleData();
    
    if (widget.vehicleInfo != null) {
      licencePlateNumberController.text = widget.vehicleInfo!.licencePlateNumber!;
      Get.find<ProfileController>().setStartDate(DateTime.parse(widget.vehicleInfo!.licenceExpireDate!));
      Get.find<ProfileController>().setFuelType(widget.vehicleInfo!.fuelType!, false);
      parcelWeightCapacity.text = (widget.vehicleInfo?.parcelWeightCapacity ?? '').toString();
    }
    
    _buildSteps();
  }

  void _buildSteps() {
    _steps.clear();
    _steps.addAll([
      // Step 1: Vehicle Details
      Step(
        title: Text('vehicle_details'.tr),
        content: _buildVehicleDetailsStep(),
        isActive: _currentStep == 0,
      ),
      // Step 2: Document Uploads
      Step(
        title: Text('document_uploads'.tr),
        content: _buildDocumentUploadStep(),
        isActive: _currentStep == 1,
      ),
      // Step 3: Verification Status
      Step(
        title: Text('verification_status'.tr),
        content: _buildVerificationStatusStep(),
        isActive: _currentStep == 2,
      ),
    ]);
  }

  Widget _buildVehicleDetailsStep() {
    final profileController = Get.find<ProfileController>();
    final splashController = Get.find<SplashController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vehicle Type
        Text('${'vehicle_type'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
          ),
          child: DropdownButton<Category>(
            items: profileController.categoryList.map((item) {
              return DropdownMenuItem<Category>(
                value: item,
                child: Text(item.name!.tr, style: textRegular),
              );
            }).toList(),
            onChanged: (newVal) {
              profileController.setCategoryIndex(newVal!, true);
              setState(() {});
            },
            isExpanded: true,
            underline: const SizedBox(),
            value: profileController.selectedCategory,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Brand & Model
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'vehicle_brand'.tr} *', style: textMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                    ),
                    child: DropdownButton<Brand>(
                      items: profileController.brandList.map((item) {
                        return DropdownMenuItem<Brand>(
                          value: item,
                          child: Text(item.name!.tr, style: textRegular),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        profileController.setBrandIndex(newVal!, true);
                        setState(() {});
                      },
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: profileController.selectedBrand,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            
            // Model
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'vehicle_model'.tr} *', style: textMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                    ),
                    child: DropdownButton<VehicleModels>(
                      items: profileController.modelList.map((item) {
                        return DropdownMenuItem<VehicleModels>(
                          value: item,
                          child: Text(item.name!.tr, style: textRegular),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        profileController.setModelIndex(newVal!, true);
                        setState(() {});
                      },
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: profileController.selectedModel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Year of Manufacture
        Text('${'year_of_manufacture'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        TextField(
          controller: yearOfManufactureController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'e.g. 2018',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
              borderSide: BorderSide(width: 0.5, color: Theme.of(context).hintColor),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Color
        Text('${'color'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        ColorPickerWidget(
          onColorSelected: (color) {
            setState(() {
              selectedColor = color;
              colorController.text = colorToString(color);
            });
          },
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // License Plate
        Text('${'license_plate'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        TextField(
          controller: licencePlateNumberController,
          decoration: InputDecoration(
            hintText: 'EX: DB-3212',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
              borderSide: BorderSide(width: 0.5, color: Theme.of(context).hintColor),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Capacity
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Seating Capacity
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'seating_capacity'.tr} *', style: textMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  TextField(
                    controller: seatingCapacityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. 4',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                        borderSide: BorderSide(width: 0.5, color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault),
            
            // Cargo Capacity
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'cargo_capacity'.tr} (kg)', style: textMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  TextField(
                    controller: cargoCapacityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. 200',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                        borderSide: BorderSide(width: 0.5, color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Service Type
        Text('${'service_type'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Wrap(
          spacing: Dimensions.paddingSizeSmall,
          children: (splashController.config?.serviceTypes ?? []).map((type) {
            return FilterChip(
              label: Text(type.tr),
              selected: selectedServiceTypes.contains(type),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedServiceTypes.add(type);
                  } else {
                    selectedServiceTypes.remove(type);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Fuel Type
        Text('${'fuel_type'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(width: .7, color: Theme.of(context).hintColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
          ),
          child: DropdownButton<String>(
            value: profileController.selectedFuelType,
            items: splashController.config?.fuelTypes?.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.tr, style: textRegular),
              );
            }).toList(),
            onChanged: (value) {
              profileController.setFuelType(value!, true);
              setState(() {});
            },
            isExpanded: true,
            underline: const SizedBox(),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        // Baby Seat Available
        Row(
          children: [
            Checkbox(
              value: isBabySeatAvailable,
              onChanged: (value) {
                setState(() {
                  isBabySeatAvailable = value!;
                });
              },
            ),
            Text('baby_seat_available'.tr, style: textMedium),
          ],
        ),

        // Helmet Requirement
        if (profileController.selectedCategory?.name == 'Motorbike')
          Row(
            children: [
              Checkbox(
                value: isHelmetRequired,
                onChanged: (value) {
                  setState(() {
                    isHelmetRequired = value!;
                  });
                },
              ),
              Text('helmet_required'.tr, style: textMedium),
            ],
          ),

        // Load Capacity for Bakkie
        if (profileController.selectedCategory?.name == 'Bakkie')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text('${'load_capacity'.tr} (kg)', style: textMedium),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              TextField(
                controller: loadCapacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 1000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                    borderSide: BorderSide(width: 0.5, color: Theme.of(context).hintColor),
                  ),
                ),
              ),
            ],
          ),

        const SizedBox(height: Dimensions.paddingSizeDefault),
        // Vehicle Photos
        Text('${'vehicle_photos'.tr} *', style: textMedium),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        _buildVehiclePhotoUpload(),
      ],
    );
  }

  Widget _buildDocumentUploadStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Document List
        Text('required_documents'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        
        // Document Items
        _buildDocumentItem('registration_papers'.tr, 'Upload proof of vehicle registration'),
        _buildDocumentItem('insurance'.tr, 'Upload insurance documents'),
        _buildDocumentItem('roadworthy_certificate'.tr, 'Upload roadworthy certificate'),
        _buildDocumentItem('driver_permit'.tr, 'Upload your driver permit'),
      ],
    );
  }

  Widget _buildVehiclePhotoUpload() {
    return Column(
      children: [
        _buildPhotoItem('front'.tr),
        _buildPhotoItem('back'.tr),
        _buildPhotoItem('side'.tr),
        _buildPhotoItem('interior'.tr),
        _buildPhotoItem('license_plate'.tr),
      ],
    );
  }

  Widget _buildPhotoItem(String title) {
    final index = vehiclePhotoFiles.indexWhere((file) => file.name.contains(title));
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          ElevatedButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(type: FileType.image);
              if (result != null) {
                setState(() {
                  if (index != -1) {
                    vehiclePhotoFiles[index] = result.files.first;
                  } else {
                    vehiclePhotoFiles.add(result.files.first);
                  }
                });
              }
            },
            child: Text(index != -1 ? 'change_photo'.tr : 'upload_photo'.tr),
          ),
          if (index != -1)
            Image.file(
              File(vehiclePhotoFiles[index].path!),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String title, String description) {
    final index = documentFiles.indexWhere((file) => file.name.contains(title));
    final status = index >= 0 ? uploadedDocumentStatus[index] : 'pending';

    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textMedium),
              Chip(
                label: Text(status.tr, style: textRegular.copyWith(color: Colors.white)),
                backgroundColor: status == 'approved' ? Colors.green : 
                              status == 'rejected' ? Colors.red : Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text(description, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'pdf'],
                  );
                  if (result != null) {
                    setState(() {
                      if (index != -1) {
                        documentFiles[index] = result.files.first;
                      } else {
                        documentFiles.add(result.files.first);
                        uploadedDocumentStatus.add('pending');
                      }
                    });
                  }
                },
                child: Text(index != -1 ? 'change_file'.tr : 'upload_file'.tr),
              ),
              if (index != -1) ...[
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Text(documentFiles[index].name, maxLines: 1, overflow: TextOverflow.ellipsis)),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      documentFiles.removeAt(index);
                      uploadedDocumentStatus.removeAt(index);
                    });
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStatusStep() {
    final profileController = Get.find<ProfileController>();
    final vehicleStatus = profileController.profileInfo?.vehicle?.vehicleRequestStatus ?? 'pending';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (vehicleStatus == 'pending') ...[
          const SpinKitCircle(color: Colors.orange, size: 50.0),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text('verification_pending_message'.tr, textAlign: TextAlign.center),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text('${'estimated_time'.tr}: 24-48 hours', style: textRegular.copyWith(color: Theme.of(context).hintColor)),
        ],
        if (vehicleStatus == 'approved') ...[
          const Icon(Icons.check_circle, color: Colors.green, size: 50.0),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text('verification_approved_message'.tr, textAlign: TextAlign.center),
        ],
        if (vehicleStatus == 'denied') ...[
          const Icon(Icons.cancel, color: Colors.red, size: 50.0),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text('verification_denied_message'.tr, textAlign: TextAlign.center),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text('${'reason'.tr}: ${profileController.profileInfo?.vehicle?.rejectionReason ?? 'N/A'}', style: textRegular.copyWith(color: Theme.of(context).hintColor)),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          ButtonWidget(
            buttonText: 'edit_vehicle_info'.tr,
            onPressed: () {
              setState(() {
                _currentStep = 0;
              });
            },
          ),
        ],
        const SizedBox(height: Dimensions.paddingSizeLarge),
        TextButton(
          onPressed: () {
            // Navigate to Help & Support
          },
          child: Text('contact_support'.tr),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textMedium),
          Text(value, style: textRegular),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          title: widget.vehicleInfo == null ? 'vehicle_setup'.tr : 'update_vehicle'.tr,
          regularAppbar: true,
        ),
        body: Stepper(
          currentStep: _currentStep,
          steps: _steps,
          onStepContinue: () {
            if (_currentStep < _steps.length - 1) {
              setState(() => _currentStep++);
            } else {
              _submitVehicle();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              Get.back();
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: ButtonWidget(
                        buttonText: 'back'.tr,
                        buttonType: ButtonType.outlined,
                        onPressed: details.onStepCancel,
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(
                    child: ButtonWidget(
                      buttonText: _currentStep == _steps.length - 1 ? 'submit'.tr : 'next'.tr,
                      onPressed: details.onStepContinue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitVehicle() {
    final profileController = Get.find<ProfileController>();
    final currentYear = DateTime.now().year;

    if (profileController.selectedBrand == null ||
        profileController.selectedModel == null ||
        profileController.selectedCategory == null ||
        yearOfManufactureController.text.isEmpty ||
        int.tryParse(yearOfManufactureController.text) == null ||
        int.parse(yearOfManufactureController.text) < 1900 ||
        int.parse(yearOfManufactureController.text) > currentYear ||
        licencePlateNumberController.text.isEmpty ||
        selectedServiceTypes.isEmpty ||
        documentFiles.length < 4 ||
        vehiclePhotoFiles.length < 5) {
      showCustomSnackBar('please_fill_all_required_fields_and_upload_all_documents_and_photos'.tr);
      return;
    }

    final body = VehicleBody(
      brandId: profileController.selectedBrand!.id!,
      modelId: profileController.selectedModel.id!,
      categoryId: profileController.selectedCategory.id!,
      licencePlateNumber: licencePlateNumberController.text.trim(),
      licenceExpireDate: profileController.dateFormat.format(DateTime.now()).toString(),
      fuelType: profileController.selectedFuelType,
      driverId: profileController.profileInfo!.id ?? "123456789",
      ownership: 'driver',
      yearOfManufacture: int.tryParse(yearOfManufactureController.text),
      color: colorController.text,
      seatingCapacity: int.tryParse(seatingCapacityController.text),
      cargoCapacity: int.tryParse(cargoCapacityController.text),
      loadCapacity: int.tryParse(loadCapacityController.text),
      serviceTypes: selectedServiceTypes,
      babySeatAvailable: isBabySeatAvailable,
      helmetRequired: isHelmetRequired,
      documents: documentFiles,
      vehiclePhotos: vehiclePhotoFiles,
    );

    if (widget.vehicleInfo == null) {
      profileController.addNewVehicle(body).then((_) {
        setState(() {
          _currentStep = 2; // Move to verification status step
        });
      });
    } else {
      profileController.updateVehicle(body, profileController.driverId).then((_) {
        setState(() {
          _currentStep = 2; // Move to verification status step
        });
      });
    }
  }
}
