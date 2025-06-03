import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:mailer/mailer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info_fina/ai_screen/ai_screen.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';
import 'package:info_fina/controller/add_customer/add_customer_controller.dart';

class AddCustomer extends StatefulWidget {
  bool? isback;
  AddCustomer({this.isback = true, super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  String? currentLatitude;
  String? currentLongitude;

  final addcustomer = Get.put(CreateCostomerController());
  bool? message;
  File? _selectedImage;
  // final picker = ImagePicker();
  bool sendSms = false;
  var createLoanCntrlr = Get.put(CreateLoanController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lattitudecon = TextEditingController();
  final TextEditingController longitudecon = TextEditingController();

  final TextEditingController codeController = TextEditingController();
  final TextEditingController subCodeController = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController altMobileController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController guarantorController = TextEditingController();
  final TextEditingController otherDetailsController = TextEditingController();
  final TextEditingController addressController1 = TextEditingController();
  final TextEditingController addressController2 = TextEditingController();

  final TextEditingController addressController3 = TextEditingController();

  final TextEditingController aadharAddressCntrlr = TextEditingController();
  final TextEditingController panCardCntrlr = TextEditingController();
  final TextEditingController voteridCntrlr = TextEditingController();
  final TextEditingController customerCodeCntrlr = TextEditingController();
  var customerCntrlr = Get.put(CreateCostomerController());
  String? selectedArea;
  String selectedStatus = 'Active';
  String selectedMapAddress = 'Map A';
  String selectedIdType = 'Aadhar';
  String? selectedLine;
  String selectedSmsOption = 'SMS';
  String selectedSmsLanguage = 'English';

  final List<String> areas = ['Area A', 'Area B', 'Area C'];
  final List<String> lines = ['Line A', 'Line B', 'Line C'];
  final List<String> statusList = ['Active', 'Inactive'];
  final List<String> mapAddresses = ['Map A', 'Map B', 'Map C'];
  final List<String> idTypes = ['Aadhar', 'PAN', 'Voter ID'];
  final List<String> smsOptions = ['SMS', 'WhatsApp'];
  final List<String> smsLanguages = ['English', 'Tamil'];
  final ImagePicker picker = ImagePicker();

  int newHpl = 0;
  int newHplt = 0;
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (!mounted) return;

    setState(() {
      lattitudecon.text = position.latitude.toString();
      longitudecon.text = position.longitude.toString();
    });
  }

  Future<void> _pickImage() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image Source',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 30.sp,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(width: 10.w),
              IconButton(
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  size: 30.sp,
                  color: Colors.indigo.shade900,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        // Extract and log only the file name
        final fileName = _selectedImage!.path.split('/').last;
        logger.e('Image file name: $fileName');
      }
    }
  }

  void _saveCustomer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Customer Saved")),
    );
  }

  Future<String?> _showInputDialog(String title) {
    TextEditingController inputController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: inputController,
            decoration: InputDecoration(hintText: "Enter value"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, inputController.text),
              child: Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _addNewArea() async {
    String? newArea = await _showInputDialog("Add New Area");
    if (newArea != null && newArea.trim().isNotEmpty) {
      setState(() {
        areas.add(newArea.trim());
        selectedArea = newArea.trim();
      });
    }
  }

  void _addNewLine() async {
    String? newLine = await _showInputDialog("Add New Line");
    if (newLine != null && newLine.trim().isNotEmpty) {
      setState(() {
        lines.add(newLine.trim());
        selectedLine = newLine.trim();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Delay actions until after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getCurrentLocation();
      await fetchData();

      // Update the TextField with fetched customer ID
      if (customerCntrlr.custid != null) {
        codeController.text = customerCntrlr.custid.toString();
      }
    });
  }

  Future<void> fetchData() async {
    await customerCntrlr.getCusId();
  }

  @override
  Widget build(BuildContext context) {
    List<String> uniqueAreas = createLoanCntrlr.areaList.toSet().toList();
    final lineNames =
        createLoanCntrlr.lineList.map((e) => e.name).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AiScreen()));
          },
          backgroundColor: Colors.indigo.shade900,
          child: Image.asset(
            'asset/ai.png',
            color: Colors.white,
            height: 4.5.h,
          )),
      appBar: AppBar(
        leading: widget.isback == true
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
        title: Text('Add Customer',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [],
        backgroundColor: Color(0xFF17358B),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF17358B),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF17358B),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: Icon(Icons.add_a_photo, color: Colors.white),
                          onPressed: _pickImage),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Text("Last Customer Code: 5",
                  //     style:
                  //         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // const SizedBox(height: 16),
                  _buildBoxTextField(
                      label: "Customer Name", controller: nameController),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  _buildBoxTextField(
                      readOnly: true,
                      label: "lattitude",
                      controller: lattitudecon),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  _buildBoxTextField(
                      readOnly: true,
                      label: "longitude",
                      controller: longitudecon),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: _buildBoxTextField(
                  //             label: "Customer Code",
                  //             controller: codeController)),
                  //     const SizedBox(width: 10),
                  //     Expanded(
                  //         child: _buildBoxTextField(
                  //             label: "Sub Code",
                  //             controller: subCodeController)),
                  //   ],
                  // ),
                  SizedBox(height: 2.h),
                  _buildBoxTextField(
                      readOnly: true,
                      label: "Customer code",
                      controller: codeController),

                  SizedBox(
                    height: 2.h,
                  ),
                  _buildBoxTextField(
                      label: "Customer Order", controller: orderController),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildBoxTextField(
                      label: "Mobile Number",
                      controller: mobileController,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                  _buildBoxTextField(
                      label: "Alternate Mobile",
                      controller: altMobileController,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: sendSms,
                        onChanged: (val) => setState(() => sendSms = val!),
                      ),
                      const Text("Send SMS"),
                    ],
                  ),
                  if (sendSms) ...[
                    const SizedBox(height: 8),
                    _buildBoxDropdown(
                        "SMS Option",
                        selectedSmsOption,
                        smsOptions,
                        (val) => setState(() => selectedSmsOption = val!)),
                    const SizedBox(height: 8),
                    _buildBoxDropdown(
                        "SMS Language",
                        selectedSmsLanguage,
                        smsLanguages,
                        (val) => setState(() => selectedSmsLanguage = val!)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value:
                        lineNames.contains(selectedLine) ? selectedLine : null,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      labelText: 'Select Line',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade900),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                    items: lineNames.map((name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? newValue) async {
                      setState(() {
                        selectedLine = newValue;
                        selectedArea = null;
                        createLoanCntrlr.areaList = [];
                      });
                      await createLoanCntrlr.getArea(line: newValue);
                      setState(() {
                        createLoanCntrlr.areaList = createLoanCntrlr.areaList
                            .toSet()
                            .toList(); // Deduplicate area list
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: uniqueAreas.contains(selectedArea)
                        ? selectedArea
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Select Area',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo.shade900),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                    items: uniqueAreas.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedArea = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildBoxDropdown("Status", selectedStatus, statusList,
                      (val) => setState(() => selectedStatus = val!)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildBoxTextField(
                      label: "Maximum Loan Amount",
                      controller: loanAmountController,
                      keyboardType: TextInputType.number),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // _buildBoxTextField(
                  //     label: "Other Detail",
                  //     controller: otherDetailsController,
                  //     maxLines: 2),
                  SizedBox(height: 16),
                  _buildBoxTextField(
                      label: "Address 1",
                      controller: addressController1,
                      maxLines: 2),
                  SizedBox(
                    height: 1.h,
                  ),
                  _buildBoxTextField(
                      label: "Address 2",
                      controller: addressController2,
                      maxLines: 2),
                  SizedBox(
                    height: 1.h,
                  ),
                  _buildBoxTextField(
                      label: "Address 3",
                      controller: addressController3,
                      maxLines: 2),
                  SizedBox(height: 16),
                  // _buildBoxDropdown(
                  //     "Map Address",
                  //     selectedMapAddress,
                  //     mapAddresses,
                  //     (val) => setState(() => selectedMapAddress = val!)),
                  SizedBox(height: 16),
                  _buildBoxDropdown("ID Number Type", selectedIdType, idTypes,
                      (val) => setState(() => selectedIdType = val!)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  if (selectedIdType == 'Aadhar')
                    _buildBoxTextField(
                        label: 'Aadhar Num',
                        controller: aadharAddressCntrlr,
                        keyboardType: TextInputType.number),

                  if (selectedIdType == 'PAN')
                    _buildBoxTextField(
                        label: 'Pan Num',
                        controller: panCardCntrlr,
                        keyboardType: TextInputType.number),

                  if (selectedIdType == 'Voter ID')
                    _buildBoxTextField(
                        label: 'Voter Id',
                        controller: voteridCntrlr,
                        keyboardType: TextInputType.number),
                  if (newHpl != 0 && newHplt != 0) ...[
                    SizedBox(height: 20),
                    Text('New HPL: $newHpl', style: TextStyle(fontSize: 14.sp)),
                    Text('New HPLT: $newHplt',
                        style: TextStyle(fontSize: 14.sp)),
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                var scode = await prefs.getString('Scode');
                var mfin = await prefs.getString('Mfin');
                final fileName = _selectedImage?.path.split('/').last;
                final Map<String, dynamic> data = {
                  "name": nameController.text.trim(),
                  "pno": mobileController.text.trim(),
                  'cid': codeController.text,
                  "pnoresi1": altMobileController.text.trim(),
                  "cidl": orderController.text,
                  "address": addressController1.text.trim(),
                  "address1": addressController2.text.trim(),
                  "address2": addressController3.text.trim(),
                  "houserent": loanAmountController.text.trim(),
                  "ogeo": otherDetailsController.text.trim(),
                  "area": selectedArea,
                  "npnoresi": selectedMapAddress,
                  "nada": selectedIdType,
                  // "nbba": selectedLine,
                  'line': selectedLine,
                  "lat": lattitudecon.text,
                  "lang": longitudecon.text,
                  'status': selectedStatus,
                  "rdate": DateFormat('dd MM yyyy').format(DateTime.now()),
                  "smsOption": sendSms ? selectedSmsOption : "",
                  "nrrname": sendSms ? selectedSmsLanguage : "",
                  "nupp3": newHpl,
                  "ngi2": newHplt,
                  "uimg": fileName,
                  'ada': selectedIdType == 'Aadhar'
                      ? aadharAddressCntrlr.text
                      : selectedIdType == 'PAN'
                          ? panCardCntrlr.text
                          : selectedIdType == 'Voter ID'
                              ? voteridCntrlr.text
                              : '',
                  "mfin": mfin,
                  "scode": scode,
                  "user": "customercreate"
                };
                logger.e(data);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
                await Future.delayed(Duration(seconds: 2));
                Navigator.pop(context);
                await addcustomer.addcustomer(data: data, message: message);

                // message == true
                //     ? selectedSmsOption == 'SMS'
                //         ? await EasyLauncher.sms(
                //             number: mobileController.text,
                //             message: selectedSmsLanguage == 'English'
                //                 ? 'Congratulations Youre account is Created Successfully'
                //                 : "வாழ்த்துகள்! உங்கள் கணக்கு வெற்றிகரமாக உருவாக்கப்பட்டது")
                //         : await EasyLauncher.sendToWhatsApp(
                //             phone: mobileController.text,
                //             message: selectedSmsLanguage == 'English'
                //                 ? 'Congratulations Youre account is Created Successfully'
                //                 : 'வாழ்த்துகள்! உங்கள் கணக்கு வெற்றிகரமாக உருவாக்கப்பட்டது')
                //     : SizedBox.fromSize();
                nameController.clear();
                lattitudecon.clear();
                mobileController.clear();
                codeController.clear();
                altMobileController.clear();
                orderController.clear();
                addressController1.clear();
                addressController2.clear();
                addressController3.clear();
                loanAmountController.clear();
                otherDetailsController.clear();
                selectedArea == '';
                selectedStatus == '';
                selectedIdType == '';
                selectedLine == '';
                longitudecon.clear();
                selectedSmsLanguage == '';
                selectedSmsOption == '';
                _selectedImage == null;
                aadharAddressCntrlr.clear();
                panCardCntrlr.clear();
                voteridCntrlr.clear();
              },
              child: Container(
                height: 5.h,
                width: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.indigo.shade900,
                ),
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                )),
              ),
            ),
            SizedBox(
              height: 15.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBoxTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF17358B), width: 2),
        ),
      ),
    );
  }

  Widget _buildBoxDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF17358B), width: 2),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
