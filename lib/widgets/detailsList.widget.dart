import 'package:flutter/material.dart';


class MvoyDetailsListWidget extends StatefulWidget {
  final Map<String, String> data;
  final double? height;
  MvoyDetailsListWidget({Key? key, required this.data, this.height = 200})
      : super(key: key);

  @override
  _DetailsListWidgetState createState() => _DetailsListWidgetState();
}

class _DetailsListWidgetState extends State<MvoyDetailsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // Container(
              //   padding: EdgeInsets.only(bottom: 10),
              //   child: Text(
              //     "widget.data[index]![0]",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // )
              Container(
                // color: Colors.red,
                height: widget.height!,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    var propertiName = widget.data.entries.toList()[index].key;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            propertiName.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
            width: 3,
            height: widget.height,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                // color: Colors.blue,
                height: widget.height!,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    var propertiValue =
                        widget.data.entries.toList()[index].value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            propertiValue,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.only(top: 22),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Column(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "DURACION DE VIAJE",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "DISTANCIA DEL VIAJE",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "HORA DE SALIDA",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "HORA DE LLEGADA",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "CONDUCTOR",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "PRECIO",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         width: 10,
    //       ),
    //       Container(
    //         decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
    //         width: 3,
    //         height: 150,
    //       ),
    //       SizedBox(
    //         width: 10,
    //       ),
    //       Column(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "15 MINUTOS",
    //               style: TextStyle(fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "2.5 KILOMETROS",
    //               style: TextStyle(fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "2:45 PM",
    //               style: TextStyle(fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "2:56 PM",
    //               style: TextStyle(fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).pushNamed(
    //                   DriverDetailScreen.routeName,
    //                 );
    //               },
    //               child: const Text(
    //                 "ERNESTO ROSARIO",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.red,
    //                   decoration: TextDecoration.underline,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(bottom: 10),
    //             child: Text(
    //               "DOP: 50.00",
    //               style: TextStyle(fontWeight: FontWeight.normal),
    //             ),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
