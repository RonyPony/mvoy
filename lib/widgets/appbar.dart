import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/screens/homeScreen/homePage.screen.dart';
import 'package:mvoy/screens/mytrips/mytrips.screen.dart';
import 'package:mvoy/screens/profile/profile.screen.dart';

class MvoyAppBarWidget extends StatefulWidget {
  final Function? onMenuTap;
  const MvoyAppBarWidget({Key? key, this.onMenuTap}) : super(key: key);

  @override
  State<MvoyAppBarWidget> createState() => _MvoyAppBarWidgetState();
}

class _MvoyAppBarWidgetState extends State<MvoyAppBarWidget> {
  double? activeTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: SvgPicture.asset('assets/usuario.svg'),
            // backgroundImage: AssetImage('assets/images/cat3.png'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .05),
          Text(
            "Hola, Ernesto!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
          ),
          GestureDetector(
              onTap: () => widget.onMenuTap!(),
              child: SvgPicture.asset('assets/MENU.svg'))
        ],
      ),
    );
  }
}
