import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
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

  String? selectedCountry = 'Afghanistan'; // Default country
  String? selectedState;

  // Fetch countries using country_state_city package
  Future<List<String>> getCountries() async {
    final countries = await csc.getAllCountries();
    return countries.map((c) => c.name).toList()..sort();
  }

  // Fetch states for a given country
  Future<List<String>> getStates(String countryName) async {
    final countries = await csc.getAllCountries();
    final country = countries.firstWhere(
      (c) => c.name == countryName,
      orElse: () => csc.Country(
        isoCode: '',
        name: '',
        phoneCode: '',
        flag: '',
        currency: '',
        latitude: '',
        longitude: '',
      ),
    );
    if (country.isoCode.isEmpty) return [];
    final states = await csc.getStatesOfCountry(country.isoCode);
    return states.map((s) => s.name).toList()..sort();
  }

  @override
  void initState() {
    super.initState();
    countryNameCtrl.text = selectedCountry!;
    getStates(selectedCountry!).then((states) {
      if (states.isNotEmpty) {
        setState(() {
          selectedState = states.first;
          stateNameCtrl.text = selectedState ?? '';
        });
      } else {
        setState(() {
          selectedState = null;
          stateNameCtrl.text = '';
        });
      }
    });
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
                heightBox30,
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
                      Text('Country Name',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      FutureBuilder<List<String>>(
                        future: getCountries(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return const Text('Error loading countries');
                          }
                          final countries = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            value: selectedCountry,
                            items: countries.map((country) {
                              return DropdownMenuItem<String>(
                                value: country,
                                child: Text(
                                  country,
                                  style: TextStyle(fontSize: 16.sp),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              if (value != null) {
                                setState(() {
                                  selectedCountry = value;
                                  countryNameCtrl.text = value;
                                  selectedState = null;
                                  stateNameCtrl.text = '';
                                });
                                final states = await getStates(value);
                                setState(() {
                                  selectedState =
                                      states.isNotEmpty ? states.first : null;
                                  stateNameCtrl.text = selectedState ?? '';
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select country',
                              errorStyle: TextStyle(color: Color(0xFFED5252)),
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Select country'
                                    : null,
                          );
                        },
                      ),
                      heightBox20,
                      Text('Street Address',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      TextFormField(
                        controller: addresseCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your address',
                          errorStyle: TextStyle(color: Color(0xFFED5252)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter address'
                            : null,
                      ),
                      heightBox20,
                      Text('City',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                      heightBox10,
                      TextFormField(
                        controller: cityCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Enter your city',
                          errorStyle: TextStyle(color: Color(0xFFED5252)),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter city'
                            : null,
                      ),
                      heightBox20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180.w, // Increased width to prevent overflow
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('State',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white)),
                                heightBox10,
                                FutureBuilder<List<String>>(
                                  future: getStates(selectedCountry!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError ||
                                        !snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text('No states available');
                                    }
                                    final states = snapshot.data!;
                                    return DropdownButtonFormField<String>(
                                      value: selectedState,
                                      items: states.map((state) {
                                        return DropdownMenuItem<String>(
                                          value: state,
                                          child: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              state,
                                              style: TextStyle(fontSize: 14.sp),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        );
                                      }).toList(),
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
                                        errorStyle: TextStyle(
                                            color: Color(0xFFED5252),
                                            fontSize: 14),
                                      ),
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                              ? 'Select state'
                                              : null,
                                    );
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
                                Text('Zip Code',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white)),
                                heightBox10,
                                TextFormField(
                                  controller: zipCodeNameCtrl,
                                  decoration: const InputDecoration(
                                    hintText: 'Zip code',
                                    hintStyle: TextStyle(fontSize: 14),
                                    errorStyle:
                                        TextStyle(color: Color(0xFFED5252)),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    return null; // Optional validation
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
                                  selectedState ?? '',
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
