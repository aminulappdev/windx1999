import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:windx1999/app/modules/profile/controllers/content_controller.dart';
import 'package:windx1999/app/modules/wishlist/controller/create_wishList_controller.dart';
import 'package:windx1999/app/modules/wishlist/controller/web_scraping_controller.dart';
import 'package:windx1999/app/modules/wishlist/widget/info_card.dart';
import 'package:windx1999/app/res/common_widgets/custom_app_bar.dart';
import 'package:windx1999/app/res/common_widgets/custom_background.dart';
import 'package:windx1999/app/res/common_widgets/custom_snackbar.dart';
import 'package:windx1999/app/res/custom_style/custom_size.dart';
import 'package:windx1999/get_storage.dart';

class CreateWishlistScreen extends StatefulWidget {
  const CreateWishlistScreen({super.key});

  @override
  State<CreateWishlistScreen> createState() => _CreateWishlistScreenState();
}

class _CreateWishlistScreenState extends State<CreateWishlistScreen> { 
  PlatformFile? selectedFile;
  final TextEditingController productUrlCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ContentController contentController = Get.put(ContentController());
  final CreateWishListController createWishListController = Get.put(CreateWishListController());
  final WebScrappingController webScrappingController = Get.put(WebScrappingController());

  bool isLoading = true;
  String? selectedPlatform;
  final List<String> platforms = ['amazon', 'emag', 'jumia'];

  @override
  void initState() {
    super.initState();
    _loadContent(); // Load content when screen is initialized
  }

  // Load content from the controller
  Future<void> _loadContent() async {
    await contentController.getContent();
    setState(() {
      isLoading = false; // Update loading state
    });
  }

  @override
  void dispose() {
    productUrlCtrl.dispose();
    super.dispose();
  }

  // Function to pick file (image/video)
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.single;
      });
    }
  }

  // Calculate total tokens based on scraped data and content price
  String getTotalTokens() {
    if (contentController.contentlist == null || contentController.contentlist!.isEmpty) {
      return '0';
    }

    final dynamic tokenPrice = contentController.contentlist![0].tokenPrice;
    final double? price = webScrappingController.scrapingData?.usdConvertedPrice ?? 0.0;

    if (tokenPrice is num && tokenPrice > 0 && price != null) {
      return (tokenPrice * price).round().toString();
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: CustomBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      heightBox20,
                      const CustomAppBar(title: 'Set up your Wishlist'),
                      heightBox20,
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product link',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            heightBox10,
                            TextFormField(
                              controller: productUrlCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter product link',
                                errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 237, 82, 82),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) => value == null || value.isEmpty ? 'Please enter a product link' : null,
                            ),
                            heightBox10,
                            // Dropdown to select platform (Amazon, eMag, Jumia)
                            DropdownButtonFormField<String>(
                              value: selectedPlatform,
                              hint: Text(
                                'Select Platform',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              dropdownColor: Colors.white,
                              items: platforms.map((String platform) {
                                return DropdownMenuItem<String>(
                                  value: platform,
                                  child: Text(
                                    platform.capitalize!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedPlatform = newValue;
                                });
                              },
                              validator: (value) => value == null ? 'Please select a platform' : null,
                            ),
                            heightBox10,
                            SizedBox(
                              width: 200.w,
                              height: 40,
                              child: GetBuilder<WebScrappingController>(
                                builder: (controller) {
                                  return ElevatedButton(
                                    onPressed: selectedPlatform != null && productUrlCtrl.text.isNotEmpty && !controller.inProgress
                                        ? () {
                                            webScrapping(
                                              productUrlCtrl.text,
                                              selectedPlatform!,
                                            );
                                          }
                                        : null,
                                    child: controller.inProgress
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text('Generate'),
                                  );
                                },
                              ),
                            ),
                            heightBox20,
                            // Displaying scraped product data
                            GetBuilder<WebScrappingController>(
                              builder: (scrapCtrl) {
                                if (scrapCtrl.inProgress) {
                                  return SizedBox(
                                    height: 360,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else if (scrapCtrl.scrapingData == null ||
                                    (scrapCtrl.scrapingData!.title!.isEmpty &&
                                        scrapCtrl.scrapingData!.usdConvertedPrice == 0.0 &&
                                        scrapCtrl.scrapingData!.description!.isEmpty &&
                                        scrapCtrl.scrapingData!.image!.isEmpty)) {
                                  return SizedBox(
                                    height: 360,
                                    child: Center(
                                      child: Text(
                                        'No data available',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InfoBox(
                                        title: 'Title',
                                        data: scrapCtrl.scrapingData!.title ?? '',
                                      ),
                                      heightBox10,
                                      InfoBox(
                                        title: 'Price',
                                        data: '\$${scrapCtrl.scrapingData!.usdConvertedPrice?.toStringAsFixed(2) ?? '0.00'}',
                                      ),
                                      heightBox10,
                                      InfoBox(
                                        title: 'Token',
                                        data: getTotalTokens(),
                                      ),
                                      heightBox10,
                                      // Display image if available
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 200,
                                        child: scrapCtrl.scrapingData!.image != null && scrapCtrl.scrapingData!.image!.isNotEmpty
                                            ? Image.network(
                                                scrapCtrl.scrapingData!.image!,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => const Center(
                                                  child: Text(
                                                    'No image',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const Center(
                                                child: Text(
                                                  'No image',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            heightBox24,
                            // Button to create the wishlist after generating data
                            GetBuilder<WebScrappingController>(
                              builder: (scrapCtrl) => Visibility(
                                visible: scrapCtrl.scrapingData != null &&
                                    (scrapCtrl.scrapingData!.title!.isNotEmpty ||
                                        scrapCtrl.scrapingData!.usdConvertedPrice != 0.0 ||
                                        scrapCtrl.scrapingData!.description!.isNotEmpty ||
                                        scrapCtrl.scrapingData!.image!.isNotEmpty),
                                child: GetBuilder<CreateWishListController>(
                                  builder: (controller) {
                                    return Opacity(
                                      opacity: !controller.inProgress ? 1.0 : 0.3,
                                      child: ElevatedButton(
                                        onPressed: !controller.inProgress
                                            ? () {
                                                if (_formKey.currentState!.validate()) {
                                                  createWishListFunction(
                                                    StorageUtil.getData(StorageUtil.userId) ?? '',
                                                    contentFile: selectedFile,
                                                  );
                                                }
                                              }
                                            : null,
                                        child: controller.inProgress
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Text(
                                                'Create wishlist',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            heightBox12,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  // Method to create the wishlist
  Future<void> createWishListFunction(
    String authorId, {
    PlatformFile? contentFile,
  }) async {
    if (authorId.isEmpty) {
      showSnackBarMessage(context, 'User ID is missing', true);
      return;
    }

    if (webScrappingController.scrapingData == null) {
      showSnackBarMessage(context, 'No scraped data available', true);
      return;
    }

    String title = webScrappingController.scrapingData!.title ?? '';
    String description = webScrappingController.scrapingData!.description ?? '';
    String link = productUrlCtrl.text.trim();
    double price = webScrappingController.scrapingData!.usdConvertedPrice ?? 0.0;

    final String totalTokensStr = getTotalTokens();
    final int? totalTokens = int.tryParse(totalTokensStr);
    if (totalTokens == null) {
      showSnackBarMessage(context, 'Invalid total tokens calculation', true);
      return;
    }

    print('Frontend data');
    print('image : ${webScrappingController.scrapingData!.image}');
    print('Author Id: $authorId, Title: $title, Description: $description, Link: $link, Price: $price, Token: $totalTokens');

    final bool isSuccess = await createWishListController.createWishList(
      authorId,
      title,
      description,
      link,
      price,
      totalTokens,
      webScrappingController.scrapingData!.image ?? '',
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Wishlist created');
        setState(() {
          productUrlCtrl.clear();
          selectedFile = null;
          selectedPlatform = null;
        });
        webScrappingController.srapingResponseModel = null;
        webScrappingController.update();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          createWishListController.errorMessage ?? 'Failed to create wishlist',
          true,
        );
      }
    }
  }

  // Web scraping function to fetch product details
  Future<void> webScrapping(String link, String type) async {
    final bool isSuccess = await webScrappingController.sraping(link, type);
    if (isSuccess) {
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          webScrappingController.errorMessage ?? 'Failed to scrape product details',
          true,
        );
      }
    }
  }
}

