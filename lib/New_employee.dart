import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/costom/Appbar_wave.dart';


class NewEmployee extends StatefulWidget {
  const NewEmployee({super.key});

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  
   String? selectedPrivilege;
   TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return "--:--";
    final now = DateTime.now();
    final formattedTime = DateFormat.jm().format(
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
    );
    return formattedTime;
  }
  String? selectedRole;

  final List<String> userPrivileges = [
    "Superadmin",
    "Manager",
    "Office All",
    "Collection",
    "Telecalling"
  ];

  final List<String> roles = [
    "INFOSSEL FINANCE",
    "ALL COMPANY",
  ];
    @override
  void initState() {
    super.initState();
    // Set default values to the first item in each list
    selectedPrivilege = userPrivileges.first;
    selectedRole = roles.first;
  }
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    setState(() => selectedDate = picked);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  automaticallyImplyLeading: false,
  flexibleSpace: PreferredSize(
    preferredSize: Size.fromHeight(100),
    child: Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 170,
            color: Colors.indigo.shade900,
          ),
        ),
        Positioned(
          top: 50,
          left: 60,
          child: Text(
            "New Registration",
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage() ));
            },
          ),
        ),
      ],
    ),
  ),
),
//        appBar: AppBar(
//         title: ShaderMask(
//   shaderCallback: (Rect bounds) {
//     return LinearGradient(
// colors: [Color(0xFFAB47BC), Color(0xFFFF4081)],


//  // Gradient colors
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ).
//     createShader(bounds);
//   },
//   child: Text(
//     'New Registration For Staff',
//     style: TextStyle(
//       fontSize: 24,
//       fontWeight: FontWeight.bold,
//       color: Colors.white, // Important to make the gradient visible
//     ),
//   ),
//         ),

  // //   title :Text(
  // //   'New Registration For Staff',
  // //   style: TextStyle(
  // //     fontSize: 24,
  // //     fontWeight: FontWeight.bold,
  // //     color: Colors.white, // Important to make the gradient visible
  // //   ),
  // // ),

  //       backgroundColor: Colors.indigo.shade900,
  //     ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:5.w,vertical:2.h),
              child: Container(
                height:155.h,width:90.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
               colors: [Colors.teal.shade400, Colors.indigo.shade600],
                    begin: const FractionalOffset(0.1, 0.0),
                    end: const FractionalOffset(0.8, 0.0),
                    stops: [0.0,1.0], ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
            BoxShadow(
                color:Colors.black12,
                blurRadius: 12,
                offset: Offset(1, 5),
                spreadRadius: 0,
              ),
               ],
                ),
               
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:190,top:30),
                      child: Text("Name of the Staff",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,vertical:0.4.h),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Name",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:200,top:10),
                      child: Text("E-Mail/Username",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "username",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:260,top:10),
                      child: Text("Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter password",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                    
                     Padding(
                      padding: const EdgeInsets.only(right:250,top:10),
                      child: Text("Joining Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                                   padding: EdgeInsets.symmetric(horizontal:4.w),
                                   child: TextFormField(
                                   readOnly: true,
                                    onTap: () => _selectDate(context),
                                    decoration: InputDecoration(
                                    hoverColor: Colors.amber,
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: DateFormat('yyyy-MM-dd').format(selectedDate),
                                     hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                                      suffixIcon: Icon(Icons.calendar_month_outlined, color: Colors.black),
                                     border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5),
                           ),
                          ),
                       ),
                   ),
                    Padding(
                      padding: const EdgeInsets.only(right:260,top:10),
                      child: Text("Mobile No",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                         
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Mobile No",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(right:170,top:10),
                      child: Text("Father/Spouse Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                         
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Mobile No",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),SizedBox(height:1.h,),
           Padding(
        padding: EdgeInsets.symmetric(horizontal:4.w),
         child: Row(
        children: [
      // Upload Image
      Expanded(
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.only(right:40),
              child: const Text(
                "Upload Image",
                style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                // Handle file upload logic here
              },
              child: Container(
                height: 50, // Match TextFormField height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    "Choose File",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width:10), // Spacing between fields
      
      // Address
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Staff code",
              style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50, // Same as upload container
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(),
                  hintText: "Enter code",
                ),
              ),
            ),
          ],
        ),
      ),
        ],
      ),
    ), 
     
    SizedBox(height:1.h,),
 
                     Padding(
                      padding: const EdgeInsets.only(right:280,),
                      child: Text("Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,vertical:0.2.h),
                      child: TextFormField(
                        maxLines:4,
                        decoration: InputDecoration(
                          
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Name",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),

                     Padding(
                      padding: const EdgeInsets.only(right:100,top:10),
                      child: Text("Previous year of Experience",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
  padding: EdgeInsets.symmetric(horizontal: 4.w),
  child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade300,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    hint: Text(
      "Select Experience",
      style: TextStyle(fontSize: 15, ),
    ),
    items: [
      "0-1 year",
      "0-2 years",
      "3 years",
      "4 years",
      "5 years",
      "6 years"
    ].map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue) {
      // Handle selection
      print("Selected Experience: $newValue");
    },
  ),
), 

Padding(
  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
  child: Row(
    children: [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Privilege",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedPrivilege,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              ),
              items: userPrivileges.map((String privilege) {
                return DropdownMenuItem<String>(
                  value: privilege,
                  child: Text(privilege),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPrivilege = newValue;
                });
              },
            ),
          ],
        ),
      ),
      SizedBox(width: 1.w),
      Flexible(
        child: Column(
          
          children: [
            Text(
              "Allowed Companies",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 15),
              ),
              items: roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue;
                });
              },
            ),
          ],
        ),
      ),
    ],
  ),
),    
                    Padding(
                      padding: const EdgeInsets.only(right:140,top:10),
                      child: Text("Education Qualification",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Qualification ",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                    SizedBox(height:1.h),
                     Padding(
                       padding: const EdgeInsets.only(left:20),
                       child: Row(
                         children: [
                           Text("Login Time From",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),SizedBox(width:7.w,),
                           Text("Login Time To",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                         ],
                       ),
                     ),
                     Padding(
      padding: EdgeInsets.symmetric(horizontal:4.w),
      child:Row(
          children: [
            // Start Time Field
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      labelText: "Start Time",
                      hintText: _formatTime(_startTime),
                      suffixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width:1.w),
            // End Time Field
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      labelText: "End Time",
                      hintText: _formatTime(_endTime),
                      suffixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    ),  

     Padding(
                      padding: const EdgeInsets.only(right:80,top:10),
                      child: Text("Total year/month of Experience",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Experience",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                       Padding(
                      padding: const EdgeInsets.only(right:140,top:10),
                      child: Text("Co-curricular Activities",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),),
                    ),
                     Padding(
                      padding:EdgeInsets.symmetric(horizontal:4.w,),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.amber,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Enter Activities",hintStyle: TextStyle(fontSize:15,color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )
                        ),
                      ),
                    ),
                   
            


                    
                    SizedBox(height:2.h,),
                      Padding(
                padding:EdgeInsets.symmetric(horizontal:12.h,vertical:1),
                child: Row(
                  children: [
                     Expanded(
                      child: GestureDetector(
                        // onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=> NewEmployee2()));
                          
                        // },
                        child: Container(
                          height: 5.h,
                          decoration: BoxDecoration(
                            //  gradient: LinearGradient(
                            //  colors: [Colors.blue, Colors.purple],
                            //  begin: Alignment.topLeft,
                            //  end: Alignment.bottomRight,
                            //  ),
                            color: Colors.indigo.shade900,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                   
                    
                  ],
                ),
              ),
                    
                  ],
                ),
                
                                                
              ),
            )
          ],
        ),
      ),


    );
  }
}