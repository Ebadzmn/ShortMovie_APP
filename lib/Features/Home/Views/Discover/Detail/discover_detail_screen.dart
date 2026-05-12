// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../Widgets/Custom_Text.dart';
// import '../Models/discrive_models.dart';
// import '../../Bottom_NabBar/Controller/Bottom_NabBar_Controller.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../Utils/app_icons.dart';

// class MovieDetailScreen extends StatelessWidget {
//   final DiscoverMovie movie;
//   const MovieDetailScreen({super.key, required this.movie});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize NavigationController to handle bottom nav if needed
//     // However, usually detail screens might not have bottom nav or might have a specific one.
//     // Looking at the image, it has a bottom nav bar.
//     final navController = Get.find<NavigationController>();

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image with Gradient
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: 500.h,
//             child: Stack(
//               children: [
//                 Image.asset(
//                   movie.image,
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.4),
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.8),
//                         Colors.black,
//                       ],
//                       stops: const [0.0, 0.3, 0.8, 1.0],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Scrollable Content
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 300.h), // Offset to show background
//                 // Main Info Card
//                 Container(
//                   padding: EdgeInsets.all(16.r),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF0C0C0C),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24.r),
//                       topRight: Radius.circular(24.r),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Movie Header (Title & Image)
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8.r),
//                             child: Image.asset(
//                               movie.image,
//                               width: 80.w,
//                               height: 100.h,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(width: 12.w),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                   text: movie.title,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(height: 8.h),
//                                 CustomText(
//                                   text: movie.description,
//                                   fontSize: 11.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xFFC9C9C9),
//                                   maxLines: 3,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 24.h),

//                       // Episode Range Tabs
//                       Row(
//                         children: [
//                           _buildRangeTab("1-25", true),
//                           SizedBox(width: 30.w),
//                           _buildRangeTab("26-43", false),
//                         ],
//                       ),

//                       SizedBox(height: 20.h),

//                       // Episode Grid
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 5,
//                           mainAxisSpacing: 10.h,
//                           crossAxisSpacing: 10.w,
//                           childAspectRatio: 1,
//                         ),
//                         itemCount: 25,
//                         itemBuilder: (context, index) {
//                           int episodeNum = index + 1;
//                           bool hasBadge = episodeNum >= 11;
//                           return _buildEpisodeButton(episodeNum, hasBadge);
//                         },
//                       ),
//                       SizedBox(height: 20.h),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Back Button (Fixed)
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: GestureDetector(
//                 onTap: () => Get.back(),
//                 child: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: Colors.white,
//                   size: 20.sp,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNav(navController),
//     );
//   }

//   Widget _buildRangeTab(String label, bool isSelected) {
//     return IntrinsicWidth(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: label,
//             fontSize: 24.sp, // Made larger as per the image
//             fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
//             color: isSelected
//                 ? const Color(0xFFF76212)
//                 : const Color(0xFF8E8E8E),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 4.h),
//             height: 2.h,
//             width: double.infinity,
//             color: isSelected ? const Color(0xFFF76212) : Colors.transparent,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEpisodeButton(int number, bool hasBadge) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Color(0xFF2A2A2A), // Dark grey from image
//             borderRadius: BorderRadius.circular(4.r),
//           ),
//           child: Center(
//             child: CustomText(
//               text: "$number",
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         if (hasBadge)
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(4.r),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF76212),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(8.r),
//                   bottomLeft: Radius.circular(8.r),
//                 ),
//               ),
//               child: Icon(Icons.lock_outline, color: Colors.white, size: 13.sp),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildBottomNav(NavigationController navController) {
//     return Container(
//       height: 80.h,
//       decoration: const BoxDecoration(
//         color: Colors.black,
//         border: Border(top: BorderSide(color: Colors.white, width: 0.5)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(0, "Discover", AppIcons.discover_icon, navController),
//           _buildNavItem(1, "Shorts", AppIcons.shorts_icon, navController),
//           _buildNavItem(2, "My List", AppIcons.my_list_icon, navController),
//           _buildNavItem(3, "Rewards", AppIcons.rewards_icon, navController),
//           _buildNavItem(4, "Profile", AppIcons.profile_icon, navController),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     int index,
//     String label,
//     String iconPath,
//     NavigationController controller,
//   ) {
//     final bool isSelected = controller.currentIndex.value == index;
//     return GestureDetector(
//       onTap: () {
//         controller.changeIndex(index);
//         Get.back(); // Navigate back to main screen which holds the PageView
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(iconPath, width: 24.w, height: 24.w),
//           SizedBox(height: 4.h),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 10.sp,
//               color: isSelected ? Colors.white : const Color(0xFF8E8E8E),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
