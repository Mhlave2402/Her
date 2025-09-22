import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/auth/widgets/signup_appbar_widget.dart';
import 'package:her_driver_app/helper/display_helper.dart';
import 'package:her_driver_app/helper/email_checker.dart';
import 'package:her_driver_app/helper/profile_helper.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/auth/controllers/auth_controller.dart';
import 'package:her_driver_app/features/auth/domain/models/signup_body.dart';
import 'package:her_driver_app/features/auth/widgets/text_field_title_widget.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';
import 'package:her_driver_app/common_widgets/image_widget.dart';
import 'package:her_driver_app/common_widgets/text_field_widget.dart';

class AdditionalSignUpScreen2 extends StatelessWidget {

  const AdditionalSignUpScreen2({super.key,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (authController){
          return Column(children: [
            SignUpAppbarWidget(title: 'signup_as_a_driver', progressText: '3_of_3',enableBackButton: true),
            
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text('provide_your_identity'.tr,style: textBold.copyWith(color: Theme.of(context).primaryColor,fontSize: 22))),

                        Center(
                          child: Text('this_information_will_help'.tr, style: textRegular.copyWith(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),fontSize: Dimensions.fontSizeSmall,
                          )),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
        
                        Padding(
                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                          child: Container(height: 80, width: Get.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                            ),
                            child: Center(child: Stack(
                              alignment: AlignmentDirectional.center, clipBehavior: Clip.none,
                              children: [
                                authController.pickedProfileFile == null ?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: const ImageWidget(
                                    image: '', height: 76, width: 76,
                                    placeholder: Images.personPlaceholder,
                                  ),
                                ) :
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:FileImage(File(authController.pickedProfileFile!.path)),
                                ),
        
                                Positioned(right: 5, bottom: -3,
                                    child: InkWell(
                                      onTap: () =>  authController.pickImage(false, true),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor, shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: const Icon(Icons.camera_enhance_rounded, color: Colors.white,size: 13),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            ),
                          ),
                        ),
        
                        TextFieldTitleWidget(title: '${'email'.tr}*'),
        
                        TextFieldWidget(
                          hintText: 'email'.tr,
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Images.email,
                          controller: authController.emailController,
                          focusNode: authController.emailNode,
                          nextFocus: authController.addressNode,
                          inputAction: TextInputAction.next,
                          autoFocus: authController.emailController.text.isEmpty,
                        ),
        
                        TextFieldTitleWidget(title: '${'address'.tr}*'),
        
                        TextFieldWidget(
                          hintText: 'address'.tr,
                          capitalization: TextCapitalization.words,
                          inputType: TextInputType.text,
                          prefixIcon: Images.location,
                          controller: authController.addressController,
                          focusNode: authController.addressNode,
                          nextFocus: authController.identityNumberNode,
                          inputAction: TextInputAction.next,
                        ),
        
                        TextFieldTitleWidget(title: '${'identity_type'.tr}*'),
        
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: .5, color: Theme.of(context).hintColor.withValues(alpha: .7)),
                          ),
                          child: DropdownButton<String>(
                            hint: authController.identityType == '' ?
                            Text('select_identity_type'.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)) :
                            Text(
                              authController.identityType.tr,
                              style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),
                            ),
                            items: authController.identityTypeList.map((String value) {
                              return DropdownMenuItem<String>(value: value, child: Text(value.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)));
                            }).toList(),
                            onChanged: (val) {
                              authController.setIdentityType(val!);
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                          ),
                        ),
        
                        TextFieldTitleWidget(title: '${'identification_number'.tr}*'),
        
                        TextFieldWidget(
                          hintText: 'Ex: 12345',
                          inputType: TextInputType.text,
                          prefixIcon: Images.identity,
                          controller: authController.identityNumberController,
                          focusNode: authController.identityNumberNode,
                          inputAction: TextInputAction.done,
                        ),
        
                        TextFieldTitleWidget(title: '${'identity_image'.tr}*'),
        
                        Padding(
                          padding:  const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault,
                            Dimensions.paddingSizeDefault,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount : authController.identityImages.length >= 2 ?
                            2 :
                            authController.identityImages.length + 1,
                            itemBuilder: (BuildContext context, index){
                              return index ==  authController.identityImages.length ?
                              GestureDetector(
                                onTap: ()=> authController.pickImage(false, false),
                                child: DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    strokeWidth: 2,
                                    dashPattern: const [10,5],
                                    color: Theme.of(context).hintColor,
                                    radius: const Radius.circular(Dimensions.paddingSizeSmall),
                                  ),
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.width/4.3,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(children: [
                                          Image.asset(Images.cameraPlaceholder, scale: 3),

                                          Text('upload_identity_picture'.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)))
                                        ]),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 0, right: 0, top: 0, left: 0,
                                      child: Container(decoration: BoxDecoration(
                                        color: Theme.of(context).hintColor.withValues(alpha: 0.07),
                                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                      )),
                                    ),
                                  ]),
                                ),
                              ) :
                              Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(Dimensions.paddingSizeExtraSmall),
                                      ),
                                      child:  Image.file(
                                        File(authController.identityImages[index].path),
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.width/4.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top:0,right:0,
                                  child: InkWell(
                                    onTap :() => authController.removeImage(index),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(
                                          Dimensions.paddingSizeDefault,
                                        )),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(Icons.delete_forever_rounded,color: Colors.red,size: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ]);

                            },
                          ),
                        ),

                        TextFieldTitleWidget(title: 'other_documents'.tr,paddingTop: 0),

                        Padding(
                          padding:  const EdgeInsets.fromLTRB(
                            Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault,
                            Dimensions.paddingSizeDefault,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount : authController.otherDocuments.length >= 5 ? 5 : authController.otherDocuments.length + 1,
                            itemBuilder: (BuildContext context, index){
                              return index ==  authController.otherDocuments.length ?
                              GestureDetector(
                                onTap: ()=> authController.pickOtherFile(),
                                child: Column(children: [
                                  DottedBorder(
                                    options: RoundedRectDottedBorderOptions(
                                      strokeWidth: 2,
                                      dashPattern: const [10,5],
                                      color: Theme.of(context).hintColor,
                                      radius: const Radius.circular(Dimensions.paddingSizeSmall),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.width/4.3,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(children: [
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                          Image.asset(Images.cloudUploadIcon, scale: 3),

                                          Text('upload_other_documents'.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)))
                                        ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeSmall),
                                ]),
                              ) :
                              Column(children: [
                                DottedBorder(
                                  options: RoundedRectDottedBorderOptions(
                                    strokeWidth: 2,
                                    dashPattern: const [10,5],
                                    color: Theme.of(context).hintColor,
                                    radius: const Radius.circular(Dimensions.paddingSizeSmall),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeLarge),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Flexible(child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                                        Image.asset(ProfileHelper.checkImageExtensions('${authController.otherDocuments[index].file?.name}'),height: 30,width: 30),

                                        Flexible(child: Text('${authController.otherDocuments[index].file?.name}',overflow: TextOverflow.ellipsis)),
                                      ])),

                                      InkWell(
                                        onTap :() => authController.removeFile(index),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.highlight_remove_outlined,color: Colors.red,size: 24),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),
                              ]);
                            },
                          ),
                        ),
        
                        authController.isLoading ?
                        Center(child: SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0)) :
                        ButtonWidget(buttonText: 'submit'.tr,
                            onPressed: () async {
                              String email = authController.emailController.text;
                              String address = authController.addressController.text;
                              String identityNumber = authController.identityNumberController.text;
                              if(authController.pickedProfileFile == null){
                                showCustomSnackBar('profile_image_is_required'.tr);
                              }else if(email.isEmpty){
                                showCustomSnackBar('email_is_required'.tr);
                                FocusScope.of(context).requestFocus(authController.emailNode);
                              }else if (EmailChecker.isNotValid(email)) {
                                showCustomSnackBar('enter_valid_email_address'.tr);
                                FocusScope.of(context).requestFocus(authController.emailNode);
                              }else if(address.isEmpty){
                                showCustomSnackBar('address_is_required'.tr);
                                FocusScope.of(context).requestFocus(authController.addressNode);
                              }else if(identityNumber.isEmpty){
                                showCustomSnackBar('identity_number_is_required'.tr);
                                FocusScope.of(context).requestFocus(authController.identityNumberNode);
                              }else if(authController.identityImages.isEmpty){
                                showCustomSnackBar('identity_image_is_required'.tr);
                              }else if(authController.identityType.isEmpty){
                                showCustomSnackBar('identity_type_is_required'.tr);
                              }
                              else{
                                List<String> services = [];
                                if(authController.isRideShare){
                                  services.add('ride_request');
                                }
                                if(authController.isParcelShare){
                                  services.add('parcel');
                                }
                                String? deviceToken = await FirebaseMessaging.instance.getToken();
                                SignUpBody signUpBody = SignUpBody(
                                    email: email,
                                    address: address,
                                    identityNumber: identityNumber,
                                    identificationType: authController.identityType,
                                    fName: authController.fNameController.text,
                                    lName: authController.lNameController.text,
                                    phone: authController.countryDialCode+authController.phoneController.text,
                                    password: authController.passwordController.text,
                                    confirmPassword: authController.confirmPasswordController.text,
                                    deviceToken: authController.getDeviceToken(),
                                    services: services,
                                    referralCode: authController.referralCodeController.text.trim(),
                                    fcmToken: deviceToken
                                );
                                authController.register(authController.countryDialCode, signUpBody);
                              }
                            }, radius: 50),
        
                        const SizedBox(height: Dimensions.paddingSizeDefault,),
                      ],
                    ),
                  ),
                )
            )
          ]);
        }),
      ),
    );
  }
}
