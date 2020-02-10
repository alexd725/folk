import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:folk/Controllers/ApiServices/fetch_Interests.dart';
import 'package:flutter/material.dart';
import 'package:folk/Utils/Animations/FadeAnimation.dart';

class SetupStepThree extends StatefulWidget {
  // final bday;
  // final gender;
  // final email;
  // final phone;
  // final fbId;
  // final fbName;
  // final fbEmail;
  // final fbPicUrl;
  // PincodeVerify({Key key}) : super(key: key);
  SetupStepThree(
      // {
      //this.bday,
      // this.gender,
      // this.email,
      // this.phone,
      // this.fbId,
      // this.fbName,
      // this.fbEmail,
      // this.fbPicUrl
      // }
      );

  @override
  _SetupStepThreeState createState() => _SetupStepThreeState();
}

class _SetupStepThreeState extends State<SetupStepThree> {
  List _selectedIndexs = [];
  final _search = TextEditingController();

  bool isClicked = false;
  bool isSearchFocused = false;

  Future<bool> _onBackPressed() {
    return AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            // customHeader: Image.asset("assets/images/macha.gif"),
            animType: AnimType.TOPSLIDE,
            btnOkText: "yes",
            btnCancelText: "Hell No..",
            tittle: 'Are you sure ?',
            desc: 'Do you want to exit an App',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              exit(0);
            }).show() ??
        false;
  }

  _clearSearch(){
      _search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          isSearchFocused = false; //
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false, // this avoids the overflow error
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45.0, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 38,
                          onPressed: () {
                            log('Clikced on back btn');
                            Navigator.of(context).pop(); //go back
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30.0),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: 45,
                          // margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.only(
                              top: 4, left: 16, right: 16, bottom: 2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ]),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: _search,
                            onTap: () {
                              setState(() {
                                isSearchFocused = true;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                              suffixIcon: isSearchFocused
                                  ? GestureDetector(
                                    onTapUp:_clearSearch() ,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.orange,
                                      ),
                                    )
                                  : null,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(
                    0.8,
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 30, bottom: 20),
                      child: Text(
                        "Choose Interests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(64, 75, 105, 1),
                          fontSize: 25,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    0.9,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 8.0, top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Hobby",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Color.fromRGBO(255, 112, 67, 1)),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 38,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                            future: GetInterests.getInterests(),
                            builder: (context, snapshot) {
                              final datalist = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final _isSelected =
                                            _selectedIndexs.contains(index);
                                        return Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_isSelected) {
                                                    _selectedIndexs
                                                        .remove(index);
                                                  } else {
                                                    _selectedIndexs.add(index);
                                                  }
                                                });
                                              },
                                              child: new Container(
                                                margin:
                                                    EdgeInsets.only(right: 7),
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5.2,
                                                decoration: BoxDecoration(
                                                    color: _isSelected
                                                        ? Colors.white
                                                        : Color(0xFFFFEBE7),
                                                    border: Border.all(
                                                        color: Color(
                                                            0xFFE0E0E0)),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft: Radius
                                                                .circular(50.0),
                                                            topRight: Radius
                                                                .circular(50.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0))),
                                                child: Center(
                                                  child: Text(
                                                    "${datalist[index]['iname']}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFFFF5E3A),
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: datalist.length,
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.only(left: 140.0),
                                child: Center(
                                  child: isClicked
                                      ? CircularProgressIndicator()
                                      : null,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.1,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 8.0, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Sport,Activity,Fitness",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 38,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.1,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 7),
                            // padding: const EdgeInsets.all(12.0),
                            // margin: const EdgeInsets.only(right: 5),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.1,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 7),
                            // padding: const EdgeInsets.all(12.0),
                            // margin: const EdgeInsets.only(right: 5),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 8.0, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Family",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 38,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 7),
                            // padding: const EdgeInsets.all(12.0),
                            // margin: const EdgeInsets.only(right: 5),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 8.0, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Family",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 38,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 7),
                            // padding: const EdgeInsets.all(12.0),
                            // margin: const EdgeInsets.only(right: 5),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Color(0xFFffebee),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(right: 7),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 5.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomRight: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(0.0))),
                            child: Center(
                              child: Text(
                                "culture",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(255, 112, 67, 1),
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              height: 100,
              // decoration: BoxDecoration(
              //   color:Colors.red
              // ),
              child: FadeAnimation(
                1.4,
                InkWell(
                  onTap: () {
                    log('Clikced on trouble with login');
                    Navigator.of(context).pushNamed("/location");
                  },
                  child: Container(
                    // padding: EdgeInsets.only(top: 35, bottom: 25),
                    child: Center(
                      child: Container(
                        height: 51,
                        width: MediaQuery.of(context).size.width / 1.12,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF6038), Color(0xFFFF9006)],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Next'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
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
