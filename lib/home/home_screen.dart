import 'package:flutter/material.dart';
import 'package:news_app/home/categories_widget_screen.dart';
import 'package:news_app/home/news_Screen.dart';
import 'package:news_app/home/settings_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "home";
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int index = 0  ;
  String appBarTitle = "News App";

  late List<Widget> screens = [
    CategoriesWidget(),
    const SettingsWidget(),

  ];


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/pattern.jpg"),fit: BoxFit.cover)),
      child:  Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(size: width*0.05,color: Colors.white),
          leadingWidth: width*0.14,
          title: Text(
            appBarTitle,
            style: TextStyle(fontSize: width*0.04),),
          toolbarHeight: height*0.07,
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(),
          width: width*0.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child:  Center(child: Text(
                      "News App!",
                    style: TextStyle(
                      fontSize: width*0.047,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  )),

                ),
              ),
              Expanded(
                flex: 6,
                  child: Container(
                    margin: EdgeInsets.all(width*0.02),
                    child: Column(
                      children: [
                        SizedBox(height: height*0.02,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 0;
                              appBarTitle = "News App";

                            });
                            Navigator.pop(context);

                          },
                          child: Row(
                            children: [
                              Icon(Icons.view_list,color: Colors.black,size: width*0.06,),
                              SizedBox(width: width*0.01,),
                              Text("Categories",style: TextStyle(
                                  fontSize: width*0.047,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ))
                            ],
                          ),
                        ),
                        SizedBox(height: height*0.03,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index=1;
                              appBarTitle = "Settings";
                            });
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.settings,color: Colors.black,size: width*0.06,),
                              SizedBox(width: width*0.01,),
                              Text("Settings",style: TextStyle(
                                  fontSize: width*0.047,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
        body: screens[index],

      ),
    );
  }

}

