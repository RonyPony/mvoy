import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MvoyOptionSelectorField extends StatefulWidget {
  final String placeHolder;
  final List<String> list;
  const MvoyOptionSelectorField(
      {super.key, required this.placeHolder, required this.list});

  @override
  State<MvoyOptionSelectorField> createState() =>
      _MvoyOptionSelectorFieldState();
}

class _MvoyOptionSelectorFieldState extends State<MvoyOptionSelectorField> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    String dropdownValue = widget.list.first; //list.first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: baseSize.height * .1,
          width: baseSize.width * .60,
          decoration: const BoxDecoration(),
          child: TextField(
            enabled: false,
            controller: dateController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: widget.placeHolder.toUpperCase(),
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                fillColor: const Color(0xffDDDDDD),
                filled: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 11),
          child: GestureDetector(
            onTap: () async {
              // showModalBottomSheet<void>(
              //   shape: const RoundedRectangleBorder(
              //     // <-- SEE HERE
              //     borderRadius: BorderRadius.vertical(
              //       top: Radius.circular(25.0),
              //     ),
              //   ),
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Container(
              //       height: 200,
              //       color: Colors.amber,
              //       child: Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             const Text('Modal BottomSheet'),
              //             ElevatedButton(
              //               child: const Text('Close BottomSheet'),
              //               onPressed: () => Navigator.pop(context),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );

              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "Selecciona una opcion",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  // decoration: BoxDecoration(color: Colors.red),
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(left: 10),
                                    itemCount: widget.list.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(widget.list[index]),
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffDDDDDD),
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset("assets/date.svg"),
            ),
          ),
        )
      ],
    );
  }
}
