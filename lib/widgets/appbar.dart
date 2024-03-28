import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/providers/currentUser.provider.dart';
import 'package:provider/provider.dart';

class MvoyAppBarWidget extends StatefulWidget {
  final Function onMenuTap;
  const MvoyAppBarWidget({Key? key, required this.onMenuTap}) : super(key: key);

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
    return Consumer<UserProvider>(builder: (context, value, widget){

      if(value.currentUser == null){
        return _buildError(); 
      }
      return _buildAppBar("${(value.currentUser!.name)}");
    });
      
      }


  _buildError(){
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
            "Cargando...",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
          ),
          GestureDetector(
              onTap: () => widget.onMenuTap(),
              child: SvgPicture.asset('assets/MENU.svg'))
        ],
      ),
    );   
  }

    _buildAppBar(String name){
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
            "HOLA ${(name)}".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
          ),
          GestureDetector(
              onTap: () => widget.onMenuTap(),
              child: SvgPicture.asset('assets/MENU.svg'))
        ],
      ),
    );   
  }
    
  }


