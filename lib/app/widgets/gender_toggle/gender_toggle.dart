// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';

// import '../../common/common.dart';

// // class GenderToggle extends StatefulWidget {
// //   final String title;
// //   // final String value;

// //   const GenderToggle({
// //     super.key,
// //     this.title = 'Gender',
// //     // required this.value,
// //   });

// //   @override
// //   State<GenderToggle> createState() => _GenderToggleState();
// // }

// // class _GenderToggleState extends State<GenderToggle> {
// //   int isSelected = 0;

// //   List<String> genderList = [
// //     'male',
// //     'female',
// //     'transgender',
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;

// //     return Container(
// //       margin: EdgeInsets.symmetric(
// //         horizontal: size.width * 0.11,
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             widget.title,
// //             style: const TextStyle(
// //               fontFamily: mainFontFamily,
// //               fontWeight: FontWeight.w500,
// //               letterSpacing: 0.02,
// //               color: textPrimaryColor,
// //               fontSize: 14,
// //             ),
// //           ),
// //           SizedBox(
// //             height: size.height * 0.02,
// //           ),
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               _icon(0, icon: malePng),
// //               _icon(1, icon: femalePng),
// //               _icon(2, icon: transgenderPng),
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _icon(int index, {String? icon}) {
// //     Size size = MediaQuery.of(context).size;

// //     return InkResponse(
// //       onTap: () {
// //         print("***** Gender index: $index *****");
// //         String selectedGender = genderList[index];

// //         print("***** Gender index: $selectedGender *****");

// //         setState(() {
// //           isSelected = index;
// //         });
// //       },
// //       child: Container(
// //         width: size.width * 0.12,
// //         decoration: BoxDecoration(
// //           shape: BoxShape.circle,
// //           border: Border.all(
// //             width: size.width * 0.004,
// //             color: isSelected == index ? purpleColor1 : mainColor,
// //           ),
// //         ),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             border: Border.all(
// //               width: size.width * 0.006,
// //               color: mainColor,
// //             ),
// //           ),
// //           child: Image.asset(
// //             icon!,
// //             width: size.width * 0.11,
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class GenderToggle2 extends StatefulWidget {
//   final int index;
//   final String icon;

//   const GenderToggle2({
//     super.key,
//     required this.index,
//     required this.icon,
//   });

//   @override
//   State<GenderToggle2> createState() => _GenderToggle2State();
// }

// class _GenderToggle2State extends State<GenderToggle2> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return InkResponse(
//       onTap: () {
//         print("***** Gender index: ${widget.index} *****");
//         String selectedGender = genderList[index];

//         print("***** Gender index: $selectedGender *****");

//         setState(() {
//           isSelected = index;
//         });
//       },
//       child: Container(
//         width: size.width * 0.12,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             width: size.width * 0.004,
//             color: isSelected == index ? purpleColor1 : mainColor,
//           ),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               width: size.width * 0.006,
//               color: mainColor,
//             ),
//           ),
//           child: Image.asset(
//             icon!,
//             width: size.width * 0.11,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
