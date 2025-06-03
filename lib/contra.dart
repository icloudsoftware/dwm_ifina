import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Contra extends StatefulWidget {
  const Contra({super.key});

  @override
  State<Contra> createState() => _ContraState();
}

String? _selectedOption;
String? _selectedOption2;
DateTime? _selectedData;

class _ContraState extends State<Contra> {
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedData ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != _selectedData) {
      setState(() {
        _selectedData = pickedDate;
        _dateController.text =
            "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}"; // Format as needed
      });
    }
  }

  DateTime? _selectedOption1;

  @override
  void initState() {
    super.initState();
    _selectedOption1 = DateTime.now(); // Set current date
    _dateController.text =
        "${_selectedOption1!.day}/${_selectedOption1!.month}/${_selectedOption1!.year}"; // Format and display
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 100, // Set your preferred height here
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            SizedBox(width: 10),
            Text(
              "Contra Entry",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

// appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 2, 2, 103),
//         title: Text(
//           "Contra Entry",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
      body: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: DropdownButtonFormField2<String>(
              dropdownStyleData: DropdownStyleData(
                offset: Offset(0, -10), // Adjusts menu position
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Voucher type',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
              ),
              isExpanded: true,
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
              items: ['Bank A/c', 'cash A/c']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: DropdownButtonFormField2<String>(
              dropdownStyleData: DropdownStyleData(
                offset: Offset(0, -10),
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'To',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              isExpanded: true,
              value: _selectedOption2,
              onChanged: (String? newValue) {
                setState(() {
                  // _selectedOption2 = DateTime(2000);
                });
              },
              items: ['Bank A/c', 'Cash A/c']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: TextFormField(
              onTap: _selectDate,
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: _selectDate,
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade900,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 50,
                width: 120,
                child: Center(
                    child: Text(
                  "Enter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ],
      ),
    );
  }
}
