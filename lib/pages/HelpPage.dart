import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_space/pages/Donate_Book.dart';
import 'package:book_space/pages/GetBook.dart';
import 'package:book_space/pages/SignUpPage.dart';
import 'package:book_space/service/Auth_service..dart';
import 'package:book_space/constant.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../HomeScreen.dart';
import 'Donation.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  AuthClass authClass = AuthClass();
  void Empty(){
    setState(() {
      _emailController.text = "";
      _bookspaceid.text="";
      _phone.text="";
    });
  }
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bookspaceid = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
          backgroundColor: mBackgroundColor,
          title: "Book Space".text.xl4.bold.black.make().shimmer(
            primaryColor: Vx.blue500,
            secondaryColor: Vx.purple500,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await authClass.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SignUpPage()),
                          (route) => false);
                }),
          ],
          // backgroundColor: Colors.transparent,
          elevation: 0.2,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Need Help? Conatct Us !!",style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              Text("--------------------------------------------------"),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: mCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image(image: AssetImage("images/imgguf.gif"),height: 250,width: 250,),
                    Text("Name: Anshul Kumar",style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mBackgroundColor,
                    ),),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Email Id: 20115@iiitu.ac.in",style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mBackgroundColor,
                    ),),
                    SizedBox(
                      height:5,
                    ),
                    Text("Phone: +91-9456862963",style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: mBackgroundColor,
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Please Fill Details",style: GoogleFonts.roboto(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),),
              Text("--------------------------------------------------"),
              SizedBox(height: 15.0,),
              Container(
                decoration: BoxDecoration(
                  color: mBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height/1.9,
                margin: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Enter Your Mail Id                       ",
                        style: GoogleFonts.roboto(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    textItem("Email",_emailController),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Enter Book Space                       ",
                        style: GoogleFonts.roboto(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    textItem("Book Space Id                    ",_bookspaceid),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Enter Your Phone Number                  ",
                        style: GoogleFonts.roboto(
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    textItem("Phone Number",_phone),
                    SizedBox(height: 30.0,),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            try{
                              FirebaseFirestore.instance
                                  .collection("helpbook")
                                  .add({
                                'bookspaceid': _bookspaceid.text,
                                'mail': _emailController.text,
                                'phone': _phone.text,
                              });
                              print("User Added");
                              final snackbar = SnackBar(content: Text("We Will Contact You Soon!!"));
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            }
                            catch(e){
                              final snackbar = SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            }
                            Empty();
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.radioCanada(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                            mBackgroundColor2, // background (button) color
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget textItem(
      String labletxt, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: labletxt,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1.5,
                color: mCard,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ))),
      ),
    );
  }
}



class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    color: mBackgroundColor,
    height: MediaQuery.of(context).size.height / 3,
    padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Hello Anshul Kumar !!",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Welcome To The Book Space",
            style: TextStyle(
              fontSize: 20,
              color: Colors.yellowAccent,
            ),
          ),
        ],
      ),
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24),
    color: mCard,
    child: Wrap(
      runSpacing: 10,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.more),
          title: const Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text(
            'Donate Books',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const DonateBook()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text(
            'Get Books',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => const GetBook()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text(
            'Help',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => const GetBook()));
          },
        ),
        const Divider(color: Colors.black, thickness: 1),
        ListTile(
          leading: const Icon(Icons.currency_rupee),
          title: const Text('Donation', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          onTap: () async{
            AuthClass authClass = AuthClass();
            await authClass.logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => Donation()),
                    (route) => false);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(
            'LogOut',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () async {
            AuthClass authClass = AuthClass();
            await authClass.logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => SignUpPage()),
                    (route) => false);
          },
        ),
        ListTile(
          title: const Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}
