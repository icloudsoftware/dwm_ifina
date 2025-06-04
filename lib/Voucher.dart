import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Vouchers extends StatefulWidget {
  const Vouchers({super.key});

  @override
  State<Vouchers> createState() => _VouchersState();
}

class _VouchersState extends State<Vouchers> {
  
   String? _selectedOption;
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
          "Voucher",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
      //     "Voucher",
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:20),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Ledger Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ), 

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,),
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
                  hintText: 'Credit or debit',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, ),
                ),
                isExpanded: true,
                value: _selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                items: ['Credit', 'Debit']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
         
        
            
        
       
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:2.h),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ),Padding(
            padding: EdgeInsets.symmetric(horizontal:15,),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Pug Mode",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ),
          SizedBox(height:2.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:15),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
          ),SizedBox(height:3.h,),
           GestureDetector(
         onTap: (){ },
            child: Container(
             color: Colors.indigo.shade900,
            height: 50,width:120,
            child:Center(child: Text("Enter",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),))
          ),
         ),
        ],
      ),


    );
  }
}