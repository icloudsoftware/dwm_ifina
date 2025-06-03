import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/widget/list4.dart';
import 'package:info_fina/widget/list2.dart';
import 'package:info_fina/widget/list3.dart';
import 'package:info_fina/costom/Appbar_wave.dart';

class Statement extends StatefulWidget {
  const Statement({super.key});

  @override
  State<Statement> createState() => _StatementState();
}
DateTime ? _time;
class _StatementState extends State<Statement> {
   final TextEditingController _dateController = TextEditingController();
  Future<void> _select() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _time ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != _time) {
      setState(() {
        _time = pickedDate;
        _dateController.text = "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}"; 
      });
    }
  }
  DateTime ? _selectedOption;
  DateTime ? _selectedOption1;

  @override
  void initState() {

  super.initState();
  _selectedOption = DateTime.now(); 
  _dateController.text =
      "${_selectedOption!.day}/${_selectedOption!.month}/${_selectedOption!.year}"; 

      super.initState();
  _selectedOption1 = DateTime.now(); 
  _dateController1.text =
      "${_selectedOption1!.day}/${_selectedOption1!.month}/${_selectedOption1!.year}"; 
}  

DateTime ? _Date;
final TextEditingController _dateController1 = TextEditingController();
  Future<void> _select1() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _Date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != _Date) {
      setState(() {
        _Date = pickedDate;
        _dateController1.text = "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}"; 
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
          "Statement",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage() ));
            },
          ),
        ),
    ],
  ),
),
//  appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 2, 2, 103),
//         title: Text(
//           "Statement",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height:2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
               child: TextFormField(
                   onTap: _select,
             controller: _dateController,
             readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
             ),
              suffixIcon: IconButton(
             onPressed: _select,
             icon: Icon(Icons.calendar_month_outlined),
            ),
          ),
          ),
          ),
            SizedBox(height:2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
               child: TextFormField(
                   onTap: _select1,
             controller: _dateController1,
             readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
             ),
              suffixIcon: IconButton(
             onPressed: _select1,
             icon: Icon(Icons.calendar_month_outlined),
            ),
          ),
          ),
          ),
          SizedBox(height:2.h,),
          GestureDetector(
           onTap: (){ },
              child: Container(
               color: Colors.indigo.shade900,
              height: 50,width:120,
              child:Center(child: Text("Enter",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),))
            ),
           ),
          SizedBox(height:2.h,),
           Text("INFOSSEL FINANCE",style: TextStyle(color: Colors.red,fontSize:30,fontWeight: FontWeight.bold),),
          Text("Daily Summary",style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold),),
         SizedBox(height:2.h,),
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:100),
                child: Row(
                  children: [
                    Text("Opening Balance Rs : 34760853",style: TextStyle(color: Colors.purple.shade600,fontWeight: FontWeight.bold,fontSize:21,),),
                  ],
                ),
              ),
               SizedBox(height:1.h,),
             CustomCustom(),
             SizedBox(height:2.h,),
             Padding(
                padding: const EdgeInsets.only(right:100),
                child: Text("CLOSING BALANCE Rs : 34760853",style: TextStyle(color: Colors.purple.shade600,fontWeight: FontWeight.bold,fontSize:21,),),
              ),
              SizedBox(height:0.5.h,),
             Column(
              children: [
                	custom2(),
                   SizedBox(height:2.h,),
             Padding(
                padding: const EdgeInsets.only(left:10),
                child:  Row(
                  children: [
                    Text("CASH DENOMINATION",style: TextStyle(color: Colors.purple.shade600,fontWeight: FontWeight.bold,fontSize:21,),),
                  ],
                ),
              ),
                  Custom3(),
                  SizedBox(height:2.h,),
                 
              SizedBox(height:2.h,),
              ],
             )
            ],
           )
          ],
        ),
      ),
    );
  }
}