import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:bounce/bounce.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';

class CreateLoan extends StatefulWidget {
  bool? isBlank;
  String? name;
  String? pno;
  String? line;
  String? area;
  String? cid;
  CreateLoan(
      {this.isBlank = true,
      this.name,
      this.line,
      this.area,
      this.pno,
      this.cid,
      super.key});

  @override
  State<CreateLoan> createState() => _CreateLoanState();
}

class _CreateLoanState extends State<CreateLoan> {
  // Controllers

  final TextEditingController interestController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController givenAmountController = TextEditingController();
  final TextEditingController preIntAmountController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();
  final TextEditingController principalPartController = TextEditingController();
  final TextEditingController interestPartController = TextEditingController();
  final TextEditingController totalDueController = TextEditingController();
  final TextEditingController payModeController = TextEditingController();
  final TextEditingController documentationChargeController =
      TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController aadharcntrlr = TextEditingController();

  final TextEditingController duescontroller = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  final TextEditingController phoneCntrlr = TextEditingController();
  final TextEditingController addressCntrlr = TextEditingController();
  final TextEditingController lineCntrlr = TextEditingController();
  final TextEditingController areaCntrlr = TextEditingController();
  final TextEditingController cidCntrlr = TextEditingController();

  bool isloading = false;
  String selectedLoanType = "DAILY";
  String? selectedPaymentMode;

  Timer? _debounce;
  File? _imageFile;

  var createLoanCntrlr = Get.put(CreateLoanController());
  String? selectedValue;
  String? selectedArea;
  final List<String> options = [
    'Cash A/c',
    'Bank',
  ];
  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });
    await createLoanCntrlr.getLines();
    setState(() {
      isloading = false;
    });
  }

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

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Check if the widget is still mounted before calling setState
    if (!mounted) return;

    setState(() {
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
    });
  }

  FocusNode givenAmountFocusNode = FocusNode();

  void calculateLoanDetails() {
    final double loanAmount = double.tryParse(loanAmountController.text) ?? 0.0;
    final double givenAmount =
        double.tryParse(givenAmountController.text) ?? 0.0;
    final int tenure = int.tryParse(tenureController.text) ?? 0;

    if (loanAmount > 0 &&
        givenAmount > 0 &&
        tenure > 0 &&
        givenAmount < loanAmount) {
      final double preInterest = loanAmount - givenAmount;
      final double interestRate = (preInterest / loanAmount) * 100;
      final double principalPart = givenAmount / tenure;
      final double interestPartPerDue = preInterest / tenure;
      final double totalDuePerDue = principalPart + interestPartPerDue;

      // This will update UI safely without removing focus
      Future.microtask(() {
        interestController.text = interestRate.toStringAsFixed(2);
        preIntAmountController.text = preInterest.toStringAsFixed(2);
        principalPartController.text = principalPart.toStringAsFixed(2);
        interestPartController.text = interestPartPerDue.toStringAsFixed(2);
        totalDueController.text = totalDuePerDue.toStringAsFixed(2);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getCurrentLocation();

    nameCntrlr.text = widget.name ?? '';
    phoneCntrlr.text = widget.pno ?? '';
    lineCntrlr.text = widget.line ?? '';
    areaCntrlr.text = widget.area ?? '';
    cidCntrlr.text = widget.cid ?? '';
  }

  @override
  void dispose() {
    givenAmountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    // List<String> uniqueLines = createLoanCntrlr.lineList.toList();
    List<String> uniqueAreas = createLoanCntrlr.areaList.toSet().toList();
    final lineNames =
        createLoanCntrlr.lineList.map((e) => e.name).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 8.h,
          backgroundColor: Colors.indigo.shade900,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Create Loan",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: widget.isBlank == true
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                )
              : IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScree3()));
                  },
                )),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      widget.isBlank == false
                          ? DropdownButtonFormField<String>(
                              value: lineNames.contains(selectedValue)
                                  ? selectedValue
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Select Line',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo.shade900),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                              ),
                              items: lineNames.map((name) {
                                return DropdownMenuItem<String>(
                                  value: name,
                                  child: Text(name ?? ''),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                setState(() {
                                  selectedValue = newValue;
                                  selectedArea = null;
                                  createLoanCntrlr.areaList = [];
                                });
                                await createLoanCntrlr.getArea(line: newValue);
                                setState(() {
                                  createLoanCntrlr.areaList = createLoanCntrlr
                                      .areaList
                                      .toSet()
                                      .toList(); // Deduplicate area list
                                });
                              },
                            )
                          : buildTextFormField(
                              label: 'Line',
                              controller: lineCntrlr,
                              readOnly: true),
                      SizedBox(
                        height: 1.h,
                      ),
                      widget.isBlank == false
                          ? DropdownButtonFormField<String>(
                              value: uniqueAreas.contains(selectedArea)
                                  ? selectedArea
                                  : null,
                              decoration: InputDecoration(
                                labelText: 'Select Area',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.indigo.shade900),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
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
                            )
                          : buildTextFormField(
                              controller: areaCntrlr,
                              label: 'Area',
                              readOnly: true),
                      SizedBox(
                        height: 1.h,
                      ),
                      buildTextFormField(
                          label: 'Name',
                          controller: nameCntrlr,
                          readOnly: true),
                      buildTextFormField(
                          label: 'Phone No',
                          keyboardType: TextInputType.number,
                          autoValidate: AutovalidateMode.onUserInteraction,
                          controller: phoneCntrlr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            } else if (!RegExp(r'^[6-9]\d{9}$')
                                .hasMatch(value)) {
                              return 'Enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                          readOnly: true),
                      buildTextFormField(
                          label: 'cid', controller: cidCntrlr, readOnly: true),
                      SizedBox(height: 1.h),
                      SizedBox(height: 1.h),
                      _buildSectionTitle("Loan Details"),
                      SizedBox(height: 2.h),
                      buildDropdownField(),
                      buildTextFormFieldWithController(
                          "Loan Amount", loanAmountController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      },
                          keyboardType: TextInputType.number,
                          focusNode: givenAmountFocusNode),
                      buildTextFormFieldWithController(
                          "Given Amount", givenAmountController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }, keyboardType: TextInputType.number),
                      buildTextFormFieldWithController(
                          "Repayment Period", tenureController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }),
                      buildTextFormFieldWithController(
                          "Pre-Interest Amount", preIntAmountController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }),
                      buildTextFormFieldWithController(
                          "Principal Part", principalPartController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }),
                      buildTextFormFieldWithController(
                          "Interest Part", interestPartController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }),
                      buildTextFormFieldWithController(
                          "Total Due Amount", totalDueController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field should not empty';
                        }
                        return null;
                      }),
                      DropdownButtonFormField<String>(
                        value: selectedPaymentMode,
                        decoration: InputDecoration(
                          labelText: 'Select Payment Mode',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigo.shade900),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                        ),
                        items: options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPaymentMode = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      buildTextFormFieldWithController(
                          "Remarks", remarksController, (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'Field should not empty';
                        // }
                      }, isMultiline: true),
                      SizedBox(
                        height: 1.h,
                      ),
                      Center(
                        child: Bounce(
                          duration: Duration(milliseconds: 300),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await Future.delayed(
                                  Duration(seconds: 2)); // Wait for 2 seconds

                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var scode = await prefs.getString('Scode');
                              var mfin = await prefs.getString('Mfin');
                              Map<String, dynamic> data = {
                                "loantype": selectedLoanType,
                                'cid': cidCntrlr.text,
                                "totalhpamt": loanAmountController.value.text,
                                "interest": interestController.value.text,
                                "inter": interestPartController.value.text,
                                "hpamount": givenAmountController.value.text,
                                "duemnt": duescontroller.value.text,
                                "dueamt": principalPartController.value.text,
                                "name": nameCntrlr.value.text,
                                "pno": phoneCntrlr.value.text,
                                "area": widget.isBlank == false
                                    ? selectedArea
                                    : areaCntrlr.text,
                                "model": widget.isBlank == false
                                    ? selectedValue
                                    : lineCntrlr.text,
                                "lat": _latitudeController.text,
                                "lang": _longitudeController.text,
                                "mfin": mfin,
                                "scode": scode
                              };
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
                              await createLoanCntrlr.createLoan(data: data);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade900,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildTextFormField(
      {String? label,
      int? maxLines,
      TextEditingController? controller,
      String? Function(String?)? validator,
      AutovalidateMode? autoValidate,
      bool readOnly = false,
      TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        autovalidateMode: autoValidate,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.sp)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.sp)),
        ),
      ),
    );
  }

  Widget buildTextFormFieldWithController(String label,
      TextEditingController controller, String? Function(String?)? validator,
      {bool isMultiline = false,
      TextInputType keyboardType = TextInputType.text,
      FocusNode? focusNode}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: isMultiline ? 3 : 1,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: (_) => calculateLoanDetails(),
      ),
    );
  }

  Widget buildDropdownField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: selectedLoanType,
        items: ["DAILY", "WEEKLY", "MONTHLY"].map((type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedLoanType = value!;
            if (selectedLoanType == "DAILY") {
              tenureController.text = "100";
            } else if (selectedLoanType == "WEEKLY") {
              tenureController.text = "10";
            } else if (selectedLoanType == "MONTHLY") {
              tenureController.text = "12";
            }
            calculateLoanDetails(); // Trigger auto calculation
          });
          logger.e(selectedLoanType);
        },
        decoration: InputDecoration(
          labelText: "Loan Type",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
