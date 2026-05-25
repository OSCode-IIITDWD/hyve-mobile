import "package:flutter/material.dart";
import "package:hyve/core/theme/app_theme_light.dart";
import "package:hyve/core/theme/app_theme_dark.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hyve/features/home/view/home_page.dart";
import "signuppage.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late  bool _isvis=true;
  late  bool _isun=false;

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
            height: MediaQuery.of(context).size.height*0.49,
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
                      Text("Welcome back",style :GoogleFonts.plusJakartaSans(
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
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _isun=!_isun;
                                });
                              },
                              child: Text("Forgot?   ",style: GoogleFonts.plusJakartaSans(
                                decoration: _isun?TextDecoration.underline:TextDecoration.none,
                                color: AppColors.primary,
                              ),),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),

                        TextField(
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

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>Signuppage()));

                        },
                        child: Text("SignUp",
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.primary
                        ),),
                      )


                    ],
                  )
                ]
              ),



            ),
          ),

        ),
      ),
    );
  }
}
