import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/widgets/colors.dart';

class MvoyDateField extends StatefulWidget {
  final String placeHolder;
  final TextEditingController? receivedController;
  const MvoyDateField(
      {super.key, required this.placeHolder, this.receivedController});

  @override
  State<MvoyDateField> createState() => _MvoyDateFieldState();
}

class _MvoyDateFieldState extends State<MvoyDateField> {
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          height: baseSize.height * .1,
          width: baseSize.width * .60,
          decoration: const BoxDecoration(),
          child: TextField(
            enabled: false,
            controller: widget.receivedController,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
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
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  cancelText: "Cancelar",
                  confirmText: "Seleccionar",
                  initialDatePickerMode: DatePickerMode.year,
                  builder: (context, child) {
                    return Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                                primary: AppColors.primaryColor,
                                onPrimary: Colors.black,
                                onSurface: Colors.black),
                            textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.black))),
                        child: child!);
                  },
                  initialDate: DateTime(2024), //get today's date
                  firstDate: DateTime(
                      1880), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2024));

              setState(() {
                widget.receivedController!.text =
                    "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";
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
