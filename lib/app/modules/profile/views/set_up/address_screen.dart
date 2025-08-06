import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/setup_address_controller.dart';
import 'package:windx1999/app/modules/profile/views/set_up/country_class.dart';
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
  final SetupAddressController setupAddressController = Get.put(SetupAddressController());

  String? selectedCountry = 'Afghanistan'; // Default to a country in CountryData
  String? selectedState;

  @override
  void initState() {
    super.initState();
    countryNameCtrl.text = selectedCountry!;
    selectedState = CountryData.getStates(selectedCountry!).isNotEmpty
        ? CountryData.getStates(selectedCountry!).first
        : null;
    stateNameCtrl.text = selectedState ?? '';
  }

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
                const CustomAppBar(title: 'Set Up Your Address'),
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
                      Text('Country Name', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      DropdownButtonFormField<String>(
                        value: selectedCountry,
                        items: CountryData.getCountries().map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedCountry = value;
                              countryNameCtrl.text = value;
                              selectedState = CountryData.getStates(value).isNotEmpty
                                  ? CountryData.getStates(value).first
                                  : null;
                              stateNameCtrl.text = selectedState ?? '';
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Select country',
                          errorStyle: TextStyle(color: Color(0xFFED5252)),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'Select country' : null,
                      ),
                      heightBox20,
                      Text('Street Address', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      TextFormField(
                        controller: addresseCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your address',
                          errorStyle: TextStyle(color: Color(0xFFED5252)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => (value == null || value.isEmpty) ? 'Enter address' : null,
                      ),
                      heightBox20,
                      Text('City', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      TextFormField(
                        controller: cityCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your city',
                          errorStyle: TextStyle(color: Color(0xFFED5252)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) => (value == null || value.isEmpty) ? 'Enter city' : null,
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
                                Text('State', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                                heightBox10,
                                DropdownButtonFormField<String>(
                                  value: selectedState,
                                  items: CountryData.getStates(selectedCountry!).map((state) => DropdownMenuItem(
                                        value: state,
                                        child: Text(state),
                                      )).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedState = value;
                                        stateNameCtrl.text = value;
                                      });
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Select state',
                                    errorStyle: TextStyle(color: Color(0xFFED5252)),
                                  ),
                                  validator: (value) => (value == null || value.isEmpty) ? 'Select state' : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 170.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Zip Code', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                                heightBox10,
                                TextFormField(
                                  controller: zipCodeNameCtrl,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your zip code',
                                    errorStyle: TextStyle(color: Color(0xFFED5252)),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    // if (value == null || value.isEmpty) {
                                    //   return 'Enter zip code';
                                    // }
                                    // if (!RegExp(r'^\d{4,6}\$').hasMatch(value)) {
                                    //   return 'Enter valid zip code';
                                    // }
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
                                  selectedCountry!,
                                  addresseCtrl.text,
                                  cityCtrl.text,
                                  selectedState!,
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

  Future<void> onTapToNextButton(String userId, String country, String address, String city, String state, String zipCode) async {
    final bool isSuccess = await setupAddressController.updateAddress(
      userId,
      country,
      address,
      city,
      state,
      zipCode,
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Address updated successfully');
        Get.to(() => const UserPreferencesScreen());
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, setupAddressController.errorMessage ?? 'Failed to update address', true);
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