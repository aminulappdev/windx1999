import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/setup_address_controller.dart';
import 'package:windx1999/app/modules/profile/views/set_up/user_prefer_screen.dart';
import 'package:windx1999/app/res/app_images/assets_path.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController countryNameCtrl = TextEditingController();
  final TextEditingController addresseCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateNameCtrl = TextEditingController();
  final TextEditingController zipCodeNameCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SetupAddressController setupAddressController =
      Get.put(SetupAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox20,
                CustomAppBar(
                    title: 'Set Up Your Address'), // Fixed title capitalization
                heightBox40,
                SvgPicture.asset(
                  AssetsPath.address,
                  height: 228.h,
                  width: 305.w,
                ),
                heightBox40,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country Name',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: countryNameCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter country name',
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType:
                            TextInputType.text, // Changed to TextInputType.text
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter country name';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Text(
                        'Street Address',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: addresseCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter your address',
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType
                            .streetAddress, // Changed to streetAddress
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter address';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Text(
                        'City',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      heightBox10,
                      TextFormField(
                        controller: cityCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter your city',
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 237, 82, 82)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType:
                            TextInputType.text, // Changed to TextInputType.text
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter city';
                          }
                          return null;
                        },
                      ),
                      heightBox20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'State',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                                heightBox10,
                                TextFormField(
                                  controller: stateNameCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your state',
                                    errorStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 237, 82, 82)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType
                                      .text, // Changed to TextInputType.text
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter state';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 170.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Zip Code',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                                heightBox10,
                                TextFormField(
                                  controller: zipCodeNameCtrl,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your zip code',
                                    errorStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 237, 82, 82)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter zip code';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                heightBox24,
                GetBuilder<SetupAddressController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await onTapToNextButton(
                                  '',
                                  countryNameCtrl.text,
                                  addresseCtrl.text,
                                  cityCtrl.text,
                                  stateNameCtrl.text,
                                  zipCodeNameCtrl.text,
                                );
                              }
                            },
                      child: controller.inProgress
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Save'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(String userId, String country, String address,
      String city, String state, String zipCode) async {
    final bool isSuccess = await setupAddressController.updateAddress(
        userId, country, address, city, state, zipCode);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Address updated successfully');
        Get.to(() => const UserPreferencesScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            setupAddressController.errorMessage ?? 'Failed to update address',
            true);
      }
    }
  }

  @override
  void dispose() {
    countryNameCtrl.dispose();
    addresseCtrl.dispose();
    cityCtrl.dispose();
    stateNameCtrl.dispose();
    zipCodeNameCtrl.dispose();
    super.dispose();
  }
}
