import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

// class LoanCalculator extends StatefulWidget {
//   @override
//   _LoanCalculatorState createState() => _LoanCalculatorState();
// }

// class _LoanCalculatorState extends State<LoanCalculator> {

//   TextEditingController loanAmountController = TextEditingController();
//   TextEditingController interestController = TextEditingController();
//   TextEditingController tenureController = TextEditingController();

//   double preInterest = 0.0;
//   double givenLoan = 0.0;
//   double totalPayable = 0.0;

//   void calculateLoan() {
//     double P = double.tryParse(loanAmountController.text) ?? 0.0;
//     double R = double.tryParse(interestController.text) ?? 0.0;
//     int T = int.tryParse(tenureController.text) ?? 0;

//     if (P > 0 && R > 0 && T > 0) {
//       setState(() {
//         preInterest = (P * R * T) / 100;
//         givenLoan = P - preInterest;
//         totalPayable = P;
//       });
//     }
//   }

//   Widget buildTextField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: TextInputType.number,
//         style: TextStyle(fontWeight: FontWeight.bold),
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           filled: true,
//           fillColor: Colors.grey.shade200,
//         ),
//         onChanged: (value) => calculateLoan(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Loan Calculator")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildTextField("Loan Amount (₹)", loanAmountController),
//             buildTextField("Interest Rate (%)", interestController),
//             buildTextField("Tenure (Months)", tenureController),
//             SizedBox(height: 20),
//             Text("Pre-Interest Deduction: ₹${preInterest.toStringAsFixed(2)}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
//             Text("Given Loan Amount: ₹${givenLoan.toStringAsFixed(2)}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
//             Text("Total Payable: ₹${totalPayable.toStringAsFixed(2)}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoanForm extends StatefulWidget {
  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
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

  String selectedLoanType = "DAILY";
  DateTime? selectedLoanDate;
  DateTime? selectedDueDate;

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


  Widget buildTextFormField(String label, TextEditingController controller,
      {bool isNumber = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white 
          ),
          onChanged: (value) => calculateLoanDetails(),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedLoanType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedLoanType = value!;
          });
        },
      ),
    );
  }

  Widget buildRemarksField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: remarksController,
        maxLines: 3,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: "Remarks",
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Loan Details Form"),
        backgroundColor: Colors.white,),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildTextFormField("Intr %", interestController),
              buildTextFormField("Loan Amount", loanAmountController),
              buildTextFormField("Due months", tenureController),
              buildTextFormField("Given Amount", givenAmountController,
                  isNumber: false),
              buildTextFormField("Pre int amount", preIntAmountController,
                  isNumber: false),
              buildDropdownField("Loan Type", ["DAILY", "WEEKLY", "EMI"]),
              
              buildTextFormField("Principal part", principalPartController,
                  isNumber: false),
              buildTextFormField("Interest Part", interestPartController,
                  isNumber: false),
              buildTextFormField("Total Due amount", totalDueController,
                  isNumber: false),
              buildTextFormField("Pay mode", payModeController,
                  isNumber: false),
              buildTextFormField(
                  "Documentation Charge", documentationChargeController),
              buildRemarksField(),
            ],
          ),
        ));
  }
}