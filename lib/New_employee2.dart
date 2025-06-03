import 'package:info_fina/home.dart';
import 'package:flutter/material.dart';
import 'package:info_fina/widget/csv.dart';
import 'package:info_fina/costom/Appbar_wave.dart';

class NewEmployee2 extends StatefulWidget {
  const NewEmployee2({super.key});

  @override
  State<NewEmployee2> createState() => _NewEmployee2State();
}

class _NewEmployee2State extends State<NewEmployee2> {
  final List<Map<String, String>> staffList = [
    {
      "name": "SUPERADMIN",
      "username": "admin",
      "designation": "MD",
      "qualification": "BA",
      "experience": "5",
      "image": "", 
      "Mob":"+91 9944080105"
      
    },
    {
      "name": "Annamalaiyar Finance",
      "username": "annamalaiyar",
      "designation": "MD",
      "qualification": "BA",
      "experience": "5",
      "image": "", 
       "Mob":"+91 9944080105"
    },
  ];

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
            height: 120,
            color: Colors.indigo.shade900,
          ),
        ),
        Positioned(
          top: 50,
          left: 60,
          child: Text(
            "Staff Details",
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
      // appBar: AppBar(
      //   title:  Text(
      //       'Staff Details',
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white, 
      //       ),
      //     ),

        // title: ShaderMask(
        //   shaderCallback: (Rect bounds) {
        //     return LinearGradient(
        //       colors: [Colors.deepPurple, Colors.pink], 
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ).createShader(bounds);
        //   },
        //   child: Text(
        //     'Staff Details',
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white, 
        //     ),
        //   ),
        // ),
       
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                buildActionButton("Copy"),
                SizedBox(width: 5),
                buildActionButton("CSV"),
                SizedBox(width: 5),
                buildActionButton("Print"),
              ],
            ),

            SizedBox(height: 10),
              Padding(
              padding: EdgeInsets.symmetric(horizontal:2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color:Colors.deepPurple,width:1.5)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: staffList.length,
                itemBuilder: (context, index) {
                  final staff = staffList[index];
                  return buildStaffContainer(staff);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


 

  Widget buildStaffContainer(Map<String, String> staff) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
    colors: [Colors.teal.shade400, Colors.indigo.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Username
          Row(
            children: [
              CircleAvatar(
                backgroundImage: staff["image"]!.isEmpty
                    ? AssetImage("assets/placeholder.png") as ImageProvider
                    : NetworkImage(staff["image"]!),
                radius: 25,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staff["name"]!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    staff["username"]!,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Designation: ${staff["designation"]!}",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                "Experience: ${staff["experience"]!} yrs",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Qualification: ${staff["qualification"]!}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
            "Mob: ${staff["Mob"]!}",
            style: TextStyle(color: Colors.white),
          ),
            ],
          ),
          

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {}, 
                    child: Text("Edit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {}, 
                    child: Text("Cancel"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "More Info",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
