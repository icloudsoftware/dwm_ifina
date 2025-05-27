import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/Balance.dart';
import 'package:animate_do/animate_do.dart';
import 'package:info_fina/helper/logger.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/widget/upload_file.dart';
import 'package:info_fina/controller/create_loans/create_loan_controller.dart';
import 'package:info_fina/controller/pre_processing_loan_controller/pre_processing_controller.dart';

class WeeklyCollections extends StatefulWidget {
  const WeeklyCollections({super.key});

  @override
  State<WeeklyCollections> createState() => _WeeklyCollectionsState();
}

class _WeeklyCollectionsState extends State<WeeklyCollections> {
  TextEditingController interestController = TextEditingController();
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController givenAmountController = TextEditingController();
  TextEditingController preIntAmountController = TextEditingController();
  TextEditingController tenureController = TextEditingController();
  TextEditingController principalPartController = TextEditingController();
  TextEditingController interestPartController = TextEditingController();
  TextEditingController totalDueController = TextEditingController();
  TextEditingController payModeController = TextEditingController();
  TextEditingController documentationChargeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController nameCntroller = TextEditingController();
  TextEditingController fatherNameCntroller = TextEditingController();
  TextEditingController phoneNoCntrlr = TextEditingController();
  TextEditingController spouseNameCntrlr = TextEditingController();
  TextEditingController spousePhnoCntrlr = TextEditingController();
  TextEditingController dobCntrlr = TextEditingController();
  TextEditingController aadharCntrlr = TextEditingController();
  TextEditingController addDocumennoCntrlr = TextEditingController();
  TextEditingController addCntrlr = TextEditingController();
  TextEditingController apllicantPhotoCntrlr = TextEditingController();
  TextEditingController guarantorName = TextEditingController();
  TextEditingController guaranterAddressCntrlr = TextEditingController();
  TextEditingController guarantorPhoneCntrlr = TextEditingController();
  TextEditingController guarontorImage = TextEditingController();
  TextEditingController mothernameCntrlr = TextEditingController();

  String selectedLoanType = "DAILY";
  DateTime? selectedLoanDate;
  DateTime? selectedDueDate;
  var createLoanController = Get.put(CreateLoanController());
  void calculateLoanDetails() {
    double L = double.tryParse(loanAmountController.text) ?? 0.0;
    double I = double.tryParse(interestController.text) ?? 0.0;
    int D = int.tryParse(tenureController.text) ?? 0;

    if (L > 0 && I > 0 && D > 0) {
      double preInterest = (L * I) / 100;
      double givenLoan = L - preInterest;
      double principalPart = givenLoan / D;
      double interestPartPerDue = preInterest / D;
      double totalDuePerDue = principalPart + interestPartPerDue;

      setState(() {
        preIntAmountController.text = preInterest.toStringAsFixed(2);
        givenAmountController.text = givenLoan.toStringAsFixed(2);
        principalPartController.text = principalPart.toStringAsFixed(2);
        interestPartController.text = interestPartPerDue.toStringAsFixed(2);
        totalDueController.text = totalDuePerDue.toStringAsFixed(2);
      });
    }
  }

// Future<File?> pickImage() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     return File(pickedFile.path);
//   }
//   return null;
// }

  int _currentStep = 0;

  List<String> loanType = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 12.h,
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Weekly Loan Create",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScree3()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () {
              Get.put(() => Balance());
            },
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center all children
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  child: stepCircle(0, Icons.person, "Customer Details"),
                ),
                stepLine(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentStep = 1;
                    });
                  },
                  child: stepCircle(1, Icons.attach_money, "Loan Details"),
                ),
                stepLine(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentStep = 2;
                    });
                  },
                  child: stepCircle(2, Icons.group, "Co-Applicant & Guarantor"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    //tittle below the circle
                    Text(
                      _currentStep == 0
                          ? "Customer Details"
                          : _currentStep == 1
                              ? "Loan Details"
                              : "Co-Applicant & Guarantor",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    if (_currentStep == 0) ...[
                      buildCustomerDetailsForm(),
                    ] else if (_currentStep == 1) ...[
                      buildLoanDetailsForm(),
                    ] else if (_currentStep == 2) ...[
                      buildGuarantorDetailsForm(),
                    ],

                    SizedBox(height: 8.h),

                    // Bottom Buttons in 0,1,2 index
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Finish Button
                        if (_currentStep == 2)
                          GestureDetector(
                            onTap: () async {
                              Map<String, dynamic> data = {
                                "user": "weekly",
                                // "sbname": "John Doe",
                                "mname": mothernameCntrlr.value.text,
                                // "pnof": "9876543210",
                                // "pnom": "9876543211",
                                // "pnos": "9876543212",
                                // "doo": "2025-04-25",
                                // "imgveh5": "image5.jpg",
                                // "geow": "GeoInfo",
                                // "sonn": "Son Name",
                                // "holdd": "Some Holder",
                                // "latw": "12.9716",
                                // "langw": "77.5946",
                                // "bba": "BBA Value",
                                "bbd": loanType,
                                // "hch": "HCH123",
                                // "idate": "2025-04-20",
                                // "uname": "admin",
                                // "pwd": "secret",
                                // "vehval": "500000",
                                "dob": dobCntrlr.value.text,
                                
                                "hname": spouseNameCntrlr.value.text,
                                // "lmark": "Landmark",
                                // "cofname": "Co-Father Name",
                                // "cofname2": "Co-Father Name 2",
                                "pmode": payModeController.value.text,
                                // "cow": "Cow",
                                // "cow2": "Cow2",
                                // "oaddress": "Other Address",
                                "fname": fatherNameCntroller.value.text,
                                // "eno": "Enrollment No",
                                // "cno": "Contact No",
                                // "area": "Area Name",
                                // "hlamt": "300000",
                                // "hlreturn": "320000",
                                // "hpdate2": "2025-06-01",
                                // "cobname2": "COB Name 2",
                                // "cobpno2": "9999999993",
                                // "co2": "Co2 Info",
                                // "pnooffice": "0801234567",
                                "pnoresi": spousePhnoCntrlr.value.text,
                                // "profession": "Engineer",
                                // "dealer": "Dealer Name",
                                // "chqamt": "50000",
                                // "defamt": "0",
                                // "irr": "12.5",
                                "remarks": remarksController.value.text,
                                // "imgveh": "vehicle.jpg",
                                "mfin": "Finance Co",
                                "scode": "SC001",
                            
                                "hpamount": givenAmountController.value.text,
                                "inter": interestController.value.text,
                                "hpdate": "2025-05-01",
                                "duemnt": tenureController.value.text,
                                "dueamt": principalPartController.value.text,
                                "interest": interestPartController.value.text,
                                "total": totalDueController.value.text,
                                "name": nameCntroller.value.text,
                                "pno": phoneNoCntrlr.value.text,
                                "address": guaranterAddressCntrlr.value.text,
                                "cobname": guarantorName.value.text,
                                "cobpno": guarantorPhoneCntrlr.value.text,
                                "co": guaranterAddressCntrlr.value.text,
                                // "img": "img.jpg",
                                // "bname": "Bank Name",
                                // "bcommission": "1000",
                                "document":
                                    documentationChargeController.value.text,
                                "totalhpamt": loanAmountController.value.text,
                                // "g1": '',
                                // "g2": '',
                                // "g3": '',
                                "gi1": aadharCntrlr.value.text,
                                "gi2": addDocumennoCntrlr.value.text,
                                "gi3": addCntrlr.value.text,
                                // "b1": "B1",
                                // "b2": "B2",
                                // "b3": "B3",
                                // "bb1": "BB1",
                                // "bb2": "BB2",
                                // "bb3": "BB3",
                                // "bi1": "BI1",
                                // "bi2": "BI2",
                                // "bi3": "BI3",
                                // "nname": "Nominee Name"
                              };
                              logger.w(data);
                              await createLoanController.createWeeklyLoan(data: data);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.8.h, horizontal: 7.w),
                              decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Finish",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // Next Button
                        if (_currentStep < 2)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentStep =
                                    (_currentStep < 2) ? _currentStep + 1 : 2;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade900,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // Previous Button
                        if (_currentStep > 0)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentStep -= 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 46, 150, 162),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  "Previous",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepCircle(int stepIndex, IconData icon, String title) {
    bool isActive = _currentStep == stepIndex;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.indigo.shade900 : Colors.grey,
          ),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: 25.w,
          child: Text(title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.indigo.shade900 : Colors.grey,
              )),
        ),
      ],
    );
  }

  // Step Line Widget
  Widget stepLine() {
    return Container(width: 35, height: 5, color: Colors.indigo.shade900);
  }

  // Customer Details Form (Step 0)
  Widget buildCustomerDetailsForm() {
    // List<String> customerFields = [
    //   "Name",
    //   "Father Name",
    //   "Mother Name",
    //   "PHONE NO",
    //   "Spouse Name",
    //   "Spouse pho",
    //   "DOB",
    //   "Adhaar",
    //   "Add document No",
    //   "Add",
    //   "Applicant photo",
    // ];
    return Column(
      children: [
        buildTextFormField("Name", nameCntroller),
        buildTextFormField("Father Name", fatherNameCntroller),
        buildTextFormField("Mother Name", mothernameCntrlr),
        buildTextFormField("Phone No", phoneNoCntrlr),
        buildTextFormField("Spouse Name", spouseNameCntrlr),
        buildTextFormField("Spouse Phone No", spousePhnoCntrlr),
        buildTextFormField("DOB", dobCntrlr),
        buildTextFormField("Aadhaar ", aadharCntrlr),
        buildTextFormField("Add documnet No ", addDocumennoCntrlr),
        buildTextFormField("Add", addCntrlr),
        buildTextFormField("Applicant Image", documentationChargeController),
      ],
    );
  }

  // Loan Details Form (Step 1)
  Widget buildLoanDetailsForm() {
    return Column(
      children: [
        buildTextFormField("Intr %", interestController),
        buildTextFormField("Loan Amount", loanAmountController),
        buildTextFormField("Due  months", tenureController),
        buildTextFormField("Given Amount", givenAmountController),
        // buildTextFormField("Pre int amount", preIntAmountController),
        buildTextFormField("Principal part", principalPartController),
        buildTextFormField("Interest Part", interestPartController),
        buildTextFormField("Total Due amount", totalDueController),
        buildDropdownField("Loan Type", loanType),
        buildTextFormField("Pay mode", payModeController),
        buildTextFormField(
            "Documentation Charge", documentationChargeController),
        buildTextFormField1("Remarks", "",
            isMultiline: true, suffixIcon: Icon(Icons.person)),
      ],
    );
  }

  // index 3
  Widget buildGuarantorDetailsForm() {
    // List<String> guarantorFields = [
    //   "Guarantor Name",
    //   "Address",
    //   "Phone No",
    //   "Aadhaar",
    // ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextFormField("Guarantor Name", nameCntroller),
        buildTextFormField("Address", fatherNameCntroller),
        buildTextFormField("Phone No", mothernameCntrlr),
        buildTextFormField("Aadhaar", aadharCntrlr),
        // Existing form fields
        SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Text(
                "Upload Guarantor's Photo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 13.w),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "upload file",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Generic Form Field Builder  //index1 textformfield
  Widget buildFormFields(
    List<String> labels,
  ) {
    return Column(
      children: List.generate(labels.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(labels[index],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  // fillColor: Colors.primaries[index % Colors.primaries.length].shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter ${labels[index].toLowerCase()}",
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  //index2 textformfield
  Widget buildTextFormField(String label, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          filled: true,
          labelText: label,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => calculateLoanDetails(),
      ),
    );
  }

//index2 textformfield
  Widget buildDateField(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime) onDateSelected) {
    TextEditingController _dateController = TextEditingController(
      text: selectedDate != null
          ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
          : "",
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          filled: true,
          labelText: label,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            _dateController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            onDateSelected(pickedDate);
          }
        },
      ),
    );
  }

//index2 textformfield
  Widget buildDropdownField(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          filled: true,
          labelText: label,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(),
        ),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }

//index2 textformfield
  Widget buildTextFormField1(String label, String initialValue,
      {bool isMultiline = false, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: isMultiline ? 3 : 1,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          filled: true,
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
