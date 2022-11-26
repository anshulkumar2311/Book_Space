import 'package:book_space/pages/Donate_Book.dart';
import 'package:book_space/pages/Donation.dart';
import 'package:book_space/pages/GetBook.dart';
import 'package:book_space/pages/HelpPage.dart';
import 'package:book_space/pages/SignUpPage.dart';
import 'package:book_space/pages/about.dart';
import 'package:book_space/service/Auth_service..dart';
import 'package:book_space/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
    @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass authClass = AuthClass();
  late ScrollController scrollController;
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
              Container(
                decoration: BoxDecoration(
                  color: mBackgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("images/Logo_Bg.png"),
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Welcome To The Book_Space",
                      style: GoogleFonts.roboto(
                        color: mCard,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Get Your Own Reading",
                      style: GoogleFonts.roboto(
                        color: mCard,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> AboutPage()));
                      },
                      child: Text(
                        "Know More...",
                        style: GoogleFonts.radioCanada(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
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
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>DonateBook()));
                  print("Hello");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: mCard,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Donate Books",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Image(
                        image: AssetImage("images/book2.gif"),
                        height: 400,
                        width: MediaQuery.of(context).size.width - 30,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.format_quote,
                        size: 50,
                        color: mbutton,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,  MaterialPageRoute(builder: (builder)=>DonateBook()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "If you want to donate or give books to others then click on this and fill the form and give some information. ThankYou !!",
                            style: GoogleFonts.alice(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context,  MaterialPageRoute(builder: (builder)=>GetBook()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: mCard,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Get Books",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Image(
                        image: AssetImage("images/Book3.gif"),
                        height: 200,
                        width: MediaQuery.of(context).size.width - 50,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.format_quote,
                        size: 50,
                        color: mbutton,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          "If you want to donate or give books to others then click on this and fill the form and give some information. ThankYou !!",
                          style: GoogleFonts.alice(
                            color: Colors.black,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),

            ]
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
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
            height: 65,
          ),
          Text("Hello Anshul Kumar !!", style: GoogleFonts.roboto(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text("Welcome To The Book Space", style: GoogleFonts.alice(
            fontSize: 22,
            color: mCard,
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
             Navigator.push(context, MaterialPageRoute(builder: (builder)=> Donation()));
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

