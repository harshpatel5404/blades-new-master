// import 'package:blades/screens/create_channel.dart';
// import 'package:blades/screens/home.dart';
// import 'package:blades/screens/manage_channel.dart';
// import 'package:blades/screens/manage_payment.dart';
// import 'package:blades/screens/profile_screen.dart';
// import 'package:blades/screens/subscription.dart';
// import 'package:blades/screens/upload_content.dart';
// import 'package:blades/utils/colors.dart';
// import 'package:blades/utils/dimentions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class BottomBar extends StatefulWidget {
//   final int onTapIndex;
//   const BottomBar({Key? key, this.onTapIndex = 0}) : super(key: key);

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   List bottomIcon = [
//     "bottom1",
//     "bottom2",
//     "bottom3",
//     "bottom4",
//     "bottom5",
//   ];
//   var selectedindex = 0;
//   @override
//   void initState() {
//     super.initState();
//     selectedindex = widget.onTapIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: mHeight * 0.08,
//       width: mWidth,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
//         ],
//       ),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: bottomIcon.length,
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               if (index != 2) {
//                 selectedindex = index;
//               }
//               setState(() {});
//               switch (index) {
//                 case 0:
//                   Get.to(
//                     HomeScreen(),
//                   );
//                   break;
//                 case 1:
//                   Get.to(SubscriptionScreen());
//                   break;
//                 case 2:
//                   Get.to(CreateChannel());
//                   break;
//                 case 3:
//                   Get.to(ManageChannel());
//                   break;
//                 case 4:
//                   Get.to(ProfileScreen());
//                   break;
//                 default:
//               }
//             },
//             child: Container(
//               width: mWidth * 0.2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   SvgPicture.asset(
//                     "assets/icons/${bottomIcon[index]}.svg",
//                     height: mWidth * 0.06,
//                     width: mWidth * 0.06,
//                     color: selectedindex == index
//                         ? kSecondaryColor
//                         : Color(0xff9D9D9D),
//                   ),
//                   selectedindex == index
//                       ? Image.asset(
//                           "assets/icons/dot.png",
//                           height: 12,
//                           width: 12,
//                           color: kSecondaryColor,
//                         )
//                       : const SizedBox(
//                           height: 12,
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
