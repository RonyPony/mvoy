import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottomMenuBar.widget.dart';
import '../../widgets/drawer.widget.dart';

class DriverDetailScreen extends StatefulWidget {
  static String routeName = '/driverDetailsScreen';
  const DriverDetailScreen({super.key});

  @override
  State<DriverDetailScreen> createState() => _DriverDetailScreenState();
}

class _DriverDetailScreenState extends State<DriverDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Color.fromRGBO(255, 222, 48, 1),
          automaticallyImplyLeading: false,
          actions: [
            _buildHeader(context, () {
              _scaffoldKey.currentState!.openDrawer();
            }),
          ],
        ),
        drawer: MvoyDrawerWidget(),
        backgroundColor: Color.fromRGBO(255, 222, 48, 1),
        body: SafeArea(
          child: Column(
            children: [
              _buildSerchBar(context),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  // height: MediaQuery.of(context).size.height * .85,
                  width: MediaQuery.of(context).size.width * .95,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "kevin rosario".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: SvgPicture.asset(
                              'assets/caco.svg',
                              height: 70,
                            ))
                          ],
                        ),
                      ),
                      MvoyBottomMenuBarWidget(activeIndex: 1)
                    ],
                  )),
            ],
          ),
        ));
  }

  _buildSerchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 60,
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    'assets/moto.svg',
                    height: 10,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "  A DONDE VAMOS ?",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  fillColor: Color.fromRGBO(255, 222, 48, 1),
                  filled: true),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: SvgPicture.asset('assets/search.svg'),
          )
        ],
      ),
    );
  }

  _buildHeader(BuildContext context, Function onTap) {
    return MvoyAppBarWidget(
      onMenuTap: onTap,
    );
  }
}
