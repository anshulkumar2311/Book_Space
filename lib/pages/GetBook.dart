import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_space/pages/Donate_Book.dart';
import 'package:book_space/pages/SignUpPage.dart';
import 'package:book_space/service/Auth_service..dart';
import 'package:book_space/constant.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../HomeScreen.dart';
import 'Donation.dart';
import 'HelpPage.dart';
import 'about.dart';

class GetBook extends StatefulWidget {
  const GetBook({Key? key}) : super(key: key);

  @override
  State<GetBook> createState() => _GetBookState();
}

class _GetBookState extends State<GetBook> {
  AuthClass authClass = AuthClass();
  late String urlimg;
  late int id = 1001;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("Book_donation").snapshots();

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
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context,index){
              Map<String,dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                urlimg = document["imageurl"] == null ? "Error" :  document["imageurl"];

              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mCard,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: MediaQuery.of(context).size.height / 1.25,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image(
                          // image: AssetImage("images/Logo_Bg.png"),
                          image: urlimg==null ?const NetworkImage("https://st.depositphotos.com/1741875/1237/i/600/depositphotos_12376816-stock-photo-stack-of-old-books.jpg") : NetworkImage(urlimg),
                          height: 250,
                          width: 250,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          document["Bookname"] == null ? "Error" :  document["Bookname"] ,
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          document["Bookedition"] == null ? "Unknown" :  document["Bookedition"] ,
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          document["Bookauthor"] == null ? "Unknown" :  document["Bookauthor"],
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          document["date"] == null ? "Unknown" :  document["date"],
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Book_Space_Id- ${index+10001}",
                          style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Provided By: ",
                          style: GoogleFonts.roboto(
                            color: mBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          document["name"] == null ? "Unknown" :  document["name"],
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          document["mail"] == null ? "Unknown" :  document["mail"],
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          document["phone"] == null ? "Unknown" :  document["phone"],
                          style: GoogleFonts.alice(
                            color: mBackgroundColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=> HelpPage()));
                          },
                          child: Text(
                            "Contact Us",
                            style: GoogleFonts.radioCanada(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: mBackgroundColor2, // background (button) color
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            );
          }
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


