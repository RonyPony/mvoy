import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/mapa/map.dart';
import 'package:mvoy/widgets/colors.dart';

class MvoySearchbar  extends StatefulWidget {
  const MvoySearchbar ({super.key});

  @override
  State<MvoySearchbar > createState() => _MvoySearchbarState();
}

class _MvoySearchbarState extends State<MvoySearchbar > {


  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      FocusScope.of(context).unfocus();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 60,
            child: TextField(
              // enabled: false,
              cursorColor:Colors.black,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                print(value);
              },
              onTap: (){
                setState(() {
                  FocusScope.of(context).unfocus();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMapView()));
              },
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), 
                  ),
                  prefixIcon: SvgPicture.asset(
                    'assets/moto.svg',
                    height: 9,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(

                      // borderRadius: BorderRadius.circular(10.0),

                      ),
                  labelText: "  A DONDE VAMOS ?",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  fillColor: AppColors.primaryColor,
                  filled: true),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMapView()));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: SvgPicture.asset('assets/search.svg'),
            ),
          )
        ],
      ),
    );
  }
}