import 'package:book_space/pages/SignUpPage.dart';
import 'package:book_space/pages/about.dart';
import 'package:book_space/service/Auth_service..dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:book_space/constant.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../HomeScreen.dart';
import 'Donation.dart';
import 'GetBook.dart';
import 'HelpPage.dart';

class DonateBook extends StatefulWidget {
  const DonateBook({Key? key}) : super(key: key);

  @override
  State<DonateBook> createState() => _DonateBookState();
}

class _DonateBookState extends State<DonateBook> {
  late ScrollController scrollController;
  AuthClass authClass = AuthClass();
  void Empty() {
    setState(() {
      _usernameController.text = "";
      _emailController.text = "";
      _bookname.text = "";
      _bookedition.text = "";
      _bookauthor.text = "";
      _bookcourse.text = "";
      _pincode.text = "";
      _phone.text = "";
      _address.text = "";
      _date.text = "";
    });
  }

  CollectionReference Book_doantion =
  FirebaseFirestore.instance.collection('Book_donation');
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bookname = TextEditingController();
  TextEditingController _bookedition = TextEditingController();
  TextEditingController _bookauthor = TextEditingController();
  TextEditingController _bookcourse = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _date = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
  final picker = ImagePicker();
  File? _image;
  String? downloadUrl;

  Future imagePicker() async{
    try{
      final pick =await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pick!=null){
          _image = File(pick.path);
        }
        else{
          final snackbar = SnackBar(content: Text("No Image Selected"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      });
    }
    catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future uploadImage(File _image) async{
    String? url;
    String imgid = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref =FirebaseStorage.instance.ref().child('images').child('users$imgid');
      await ref.putFile(_image);
      url =await ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("Book_donation")
        .add({
      'Bookauthor': _bookauthor.text,
      'Bookedition': _bookedition.text,
      'Bookname': _bookname.text,
      'bookcourse': _bookcourse.text,
      'name': _usernameController.text,
      'address': _address.text,
      'date': _date.text,
      'mail': _emailController.text,
      'phone': _phone.text,
      'pincode': _pincode.text,
      'imageurl': url,
    });
    print("User Added");
    Empty();
  }

  void adddata() async{

  }

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
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mCard,
                  ),
                  height: MediaQuery.of(context).size.height * 2.1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Center(
                        child: Text(
                          "Donate Book",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "-------------------------",
                          style: TextStyle(
                            color: mBackgroundColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Image(
                          image: AssetImage("images/Book1.jpg"),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Your Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Enter Name Anshul", _usernameController),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Book Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Enter Book Name lyk RD Sharma", _bookname),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Book Edition",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Enter Book Edition 2020", _bookedition),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Author Name of Book",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Enter Author of Book", _bookauthor),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Subject or Course Name",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Subject or Course of Book", _bookcourse),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Your Mail Id",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("anshulkumar552@gmail.com", _emailController),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Your Phone Number",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("9456862963", _phone),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Your Address",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Enter Your Full Address", _address),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Enter Your Pincode Number",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("205001", _pincode),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Todays Date",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      textItem("Date (dd-mm--yyyy)", _date),
                      SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: mBackgroundColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _image == null ?  Center(
                                      child: Text("No image is Selected"),
                                    ) : Image.file(_image!),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        imagePicker().whenComplete((){
                                          uploadImage(_image!);
                                        });
                                      },
                                      child: Text("Select Image")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              uploadImage(_image!);
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
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: scrollController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            height: scrollController.position.userScrollDirection ==
                    ScrollDirection.reverse
                ? 0
                : 70,
            child: child,
          );
        },
        child: BottomNavigationBar(
          backgroundColor: mBackgroundColor,
          unselectedLabelStyle: const TextStyle(
            color: Colors.white,
          ),
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.currency_rupee,
                color: Colors.white,
              ),
              label: "Donate",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                label: "Get Books"),
          ],
        ),
      ),
    );
  }

  Widget textItem(String labletxt, TextEditingController controller) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 55,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 17,
            color: mBackgroundColor,
          ),
          decoration: InputDecoration(
            labelText: labletxt,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1.5,
                color: mBackgroundColor2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.black,
                )),
          ),
        ),
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
  Widget  buildHeader(BuildContext context) => Container(
    color: mBackgroundColor,
    height: MediaQuery.of(context).size.height/3,
    padding: EdgeInsets.only( top:24+MediaQuery.of(context).padding.top,bottom: 24),
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Hello Anshul Kumar !!", style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text("Welcome To The Book Space", style: TextStyle(
            fontSize: 20,
            color: Colors.yellowAccent,
          ),),
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
          title: const Text('Home', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> HomeScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.more),
          title: const Text('About', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> AboutPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Donate Books',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const DonateBook()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.book_online),
          title: const Text('Get Books',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const GetBook()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const HelpPage()));
          },
        ),
        const Divider(color: Colors.black,thickness: 1),
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
          title: const Text('LogOut', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          onTap: () async{
            AuthClass authClass = AuthClass();
            await authClass.logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => SignUpPage()),
                    (route) => false);
          },
        ),
        ListTile(
          title: const Text('', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
          onTap: (){},
        ),
      ],
    ),
  );
}

