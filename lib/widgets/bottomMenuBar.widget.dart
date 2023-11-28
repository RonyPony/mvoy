import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/screens/homeScreen/homePage.screen.dart';
import 'package:mvoy/screens/mytrips/mytrips.screen.dart';
import 'package:mvoy/screens/profile/profile.screen.dart';
import 'package:mvoy/widgets/colors.dart';

class MvoyBottomMenuBarWidget extends StatefulWidget {
  final double? spaceBetween;
  final double activeIndex;
  const MvoyBottomMenuBarWidget(
      {Key? key, this.spaceBetween = 15, required this.activeIndex})
      : super(key: key);

  @override
  State<MvoyBottomMenuBarWidget> createState() =>
      _MvoyBottomMenuBarWidgetState();
}

class _MvoyBottomMenuBarWidgetState extends State<MvoyBottomMenuBarWidget> {
  double? activeTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeTab = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1,
                vertical: MediaQuery.of(context).size.width * .02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: activeTab == 0
                            ? AppColors.primaryColor
                            : Colors.transparent),
                    child: SvgPicture.asset('assets/home.svg'),
                  ),
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MyTripsScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: activeTab == 1
                            ? AppColors.primaryColor
                            : Colors.transparent),
                    child: SvgPicture.asset('assets/task.svg'),
                  ),
                ),
                SizedBox(
                  width: widget.spaceBetween,
                ),
                GestureDetector(
                  onTap: () {
                    activeTab = 2;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: activeTab == 2
                            ? AppColors.primaryColor
                            : Colors.transparent),
                    child: SvgPicture.asset('assets/profile.svg'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
