import "package:flutter/material.dart";
import "package:hyve/core/theme/app_theme_light.dart";
import "package:google_fonts/google_fonts.dart";

import "home_page.dart";

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  late TextEditingController _pass=TextEditingController();
  late TextEditingController _passc=TextEditingController();
  late String _error="";

  late bool _isvis=false;
  late bool _isvisc=false;
  late bool _next=true;
  @override
  void initState(){

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppColors.theme,

      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("HYVE",style: TextStyle(color: Color.fromARGB(255,87,23,30),fontSize: 35),),

          foregroundColor: Color.fromARGB(255,87,23,30),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height*0.6,
            width: MediaQuery.of(context).size.width*0.95,
            child: Container(
              decoration: BoxDecoration(
                  color:Colors.white,

                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.border,
                    width: 2,
                  )
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 2000),
                switchInCurve: Curves.bounceIn,

                child: _next? Center(

                  child: Container(
                    child: ListView(
                      children: [Container(
                        child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Welcome to HYVE",style :GoogleFonts.plusJakartaSans(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255,87,23,30),

                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Enter your credentials to continue",style :GoogleFonts.plusJakartaSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.borderMuted,

                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:  28),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text("  COLLEGE EMAIL",style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight(500)
                                        ),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: "24bcs001",
                                          hintStyle: TextStyle(
                                              color: AppColors.border,
                                              fontWeight: FontWeight(400)
                                          ),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(vertical:  12.0,horizontal: 15),
                                            child: Container(
                                              height: 10,
                                              width: 85,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: FittedBox(child: Text("@iiitdwd.ac.in",style: GoogleFonts.plusJakartaSans(),)),
                                              ),

                                              decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.alternate_email,color: AppColors.border,),
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: AppColors.border)
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("  PASSWORD",style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight(500)
                                        ),),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),

                                    TextField(
                                      controller: _pass,
                                      obscureText: _isvis,
                                      decoration: InputDecoration(
                                          hintText: "••••••••",
                                          suffixIcon: IconButton(onPressed: (){
                                            setState(() {
                                              _isvis=!_isvis;
                                            });
                                          }, icon: _isvis?Icon(Icons.visibility_outlined,color: AppColors.border,):Icon(Icons.visibility_off_outlined,color: AppColors.border,)),
                                          hintStyle: TextStyle(

                                              color: AppColors.border,
                                              fontWeight: FontWeight(1000)
                                          ),
                                          prefixIcon: Icon(Icons.lock_outline,color: AppColors.border,),
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: AppColors.border)
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("CONFIRM PASSWORD",style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight(500)
                                        ),),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),

                                    TextField(

                                      controller: _passc,
                                      obscureText: _isvisc,
                                      decoration: InputDecoration(
                                          hintText: "••••••••",
                                          suffixIcon: IconButton(onPressed: (){
                                            setState(() {
                                              _isvisc=!_isvisc;
                                            });
                                          }, icon: _isvisc?Icon(Icons.visibility_outlined,color: AppColors.border,):Icon(Icons.visibility_off_outlined,color: AppColors.border,)),
                                          hintStyle: TextStyle(

                                              color: AppColors.border,
                                              fontWeight: FontWeight(1000)
                                          ),
                                          prefixIcon: Icon(Icons.lock_outline,color: AppColors.border,),
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(color: AppColors.border)
                                          )
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("${_error}",style: TextStyle(
                                color: Colors.red,
                              ),),
                              SizedBox(
                                height: 20-5,
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(_pass.text==_passc.text){
                                      _error="";
                                      _next=!_next;
                                    }
                                    else{
                                      _error="The Confirm password and password doesn't match";
                                    }
                                  });
                                },


                                child: Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),


                                  ),
                                  child: Center(child: Text("Next  ➯",style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),)),


                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ]
                        ),
                      )],
                    ),
                  ),
                ):Container(

                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.borderMuted.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(

                              )
                            ),

                            height: 100,
                            width: 100,
                            child: Icon(Icons.person_outline,size: 50,),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Display name",
                                  hintStyle: TextStyle(
                                      color: AppColors.border,
                                      fontWeight: FontWeight(400)
                                  ),

                                  prefixIcon: Icon(Icons.person_outline,color: AppColors.border,),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: AppColors.border)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>HomePage()));
                            }
                            ,
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),


                              ),
                              child: Center(child: Text("Signup  ➯",style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),)),


                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ),
              ),



            ),
          ),

        ),
      ),
    );
  }
}
