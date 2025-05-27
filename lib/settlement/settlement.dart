import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:info_fina/controller/active_reports/active_reports_controller.dart';

class Settlementt extends StatefulWidget {
  final String? hpl;
  final String? loantype;

  const Settlementt({this.hpl, this.loantype, super.key});

  @override
  State<Settlementt> createState() => _SettlementtState();
}

var settlementController1 = Get.put(ActiveReportsController());

class _SettlementtState extends State<Settlementt> {
  final TextEditingController loanNumberController = TextEditingController();
  final TextEditingController loanTypeController = TextEditingController();
  final TextEditingController settlementController = TextEditingController();

  Future<void> fetchData() async {
    await settlementController1.settlementAmount(
        user: widget.loantype, hpl: widget.hpl);
    final fetchedAmount = settlementController1.datas?['settlement_amount'];
    if (fetchedAmount != null) {
      settlementController.text = fetchedAmount.toString();
    } else {
      settlementController.text = '';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    loanNumberController.text = widget.hpl ?? '';
    loanTypeController.text = widget.loantype ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: PreferredSize(
            preferredSize: Size.fromHeight(15.h),
            child: Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 120,
                    color: Colors.indigo.shade900,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 60,
                  child: Text(
                    "Loan Settlement",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Loan Settlement Form",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: loanNumberController,
                readOnly: true,
                // initialValue: widget.hpl ?? "",
                decoration: InputDecoration(
                  labelText: "Loan Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: loanTypeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Loan Type",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: settlementController,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Settlement Amount",
                  hintText: "Enter settlement amount",
                  border: OutlineInputBorder(),
                ),
                validator: (Value) {
                  if (Value?.isEmpty ?? true) {
                    return "please ";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    settlementController1.submitsett(
                      loanType: widget.loantype ?? '',
                      hpl: widget.hpl ?? '',
                      payment: settlementController.text,
                    );
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.indigo.shade900,
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
