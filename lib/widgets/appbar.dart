import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/providers/auth.provider.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:provider/provider.dart';

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
    final getUser = Provider.of<AuthProvider>(context, listen: false);
    var future =getUser.getCurrentUser();
    return FutureBuilder(
      future: future, 
      builder:(context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error obteniendo lista de viajes");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
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
            "Hola, ...",
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
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
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
            "Hola, ${(snapshot.data!.name)}".toUpperCase(),
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
            "Hola, ...",
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
      },);}

  }


