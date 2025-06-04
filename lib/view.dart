import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/widget/card.dart';
import 'package:info_fina/costom/Appbar_wave.dart';

class LOAN extends StatefulWidget {
  const LOAN({super.key});

  @override
  State<LOAN> createState() => _LOANState();
}
DateTime ? _selectedData;
class _LOANState extends State<LOAN> {
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
        _dateController.text = "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}"; // Format as needed
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: PreferredSize(
  preferredSize: Size.fromHeight(100),
  child: Stack(
    children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 120,
          color:Colors.indigo.shade900
        ),
      ),
      Positioned(
        top: 50,
        left: 60,
        child: Text(
          "DAY BOOK",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
       Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScree3() ));
            },
          ),
        ),
    ],
  ),
),


      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 2, 2, 103),
      //   title: Text(
      //     "DAY BOOK",
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      // ),



    
      body:Column(
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
               child: TextFormField(
              onTap: _selectDate,
              controller: _dateController,
              readOnly: true,
               decoration: InputDecoration(
               labelText: 'From Date',
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
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, ),
               child: TextFormField(
              onTap: _selectDate,
              controller: _dateController,
              readOnly: true,
               decoration: InputDecoration(
               labelText: 'TO date',
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
           SizedBox(height:3.h),

          GestureDetector(
          onTap: (){
             },
            child: Container(
            color: Colors.indigo.shade900,
            height: 50,width:120,
           child:Center(child: Text("TOTAL",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),))
           ),
         ),
         SizedBox(height:4.h,),
         customlist(),
        ],
      ) ,
    );
  }
}