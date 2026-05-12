import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uremz100/Features/Home/Controllers/pip_controller.dart';
import 'package:uremz100/Shared/Widgets/Custom_Text.dart';
import 'package:uremz100/Utils/app_colors.dart';
import 'package:uremz100/Utils/app_images.dart';
import '../Model/shorts_model.dart';
import '../../Bottom_NabBar/Controller/Bottom_NabBar_Controller.dart';
import 'Shorts_Video_Controller.dart';

import '../More/more_screen.dart';

class ShortsController extends GetxController {
  var shortsList = <ShortsModel>[].obs;
  var isFav = false.obs;
  var isBookmarked = true.obs;
  var showLoginPopup = false.obs;
  var showMoreMenu = false.obs;
  var currentEpisode = 4.obs;
  var currentSeason = 2.obs;
  var isPipEnabled = true.obs;
  var playbackSpeed = "1.0x".obs;
  var videoQuality = "1080p".obs;
  var isDescriptionExpanded = false.obs;
  var showEpisodePopup = false.obs;
  var selectedEpisodeRange = "1-25".obs;
  var isFullSeriesMode = false.obs;
  var currentIndex = 0.obs;
  var showRewardIcon = true.obs;

  void showMoreDetailsBottomSheet() {
    pauseCurrentVideo();
    Get.bottomSheet(
      const MoreScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).then((_) {
      playCurrentVideo();
    });
  }

  @override
  void onInit() {
    super.onInit();
    shortsList.addAll([
      ShortsModel(
        videoUrl:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        title: "The Scars You Carved Into Me...",
        description:
            "Pearl Zane dates Ivan Reed, a wealthy heir pretending to be poor. When he falls in love with her, he faces a difficult choice: tell her the truth and risk losing her, or keep his secret and live a lie forever. As their relationship deepens, secrets from Ivan's past begin to surface, threatening everything they've built together. This story of love, betrayal, and redemption will keep you on the edge of your seat until the very last episode.",
        profileImage: AppImages.profile_image,
        episode: "11",
        season: "1",
        tags: ["Hot", "Secret Baby", "Winning Her Back"],
      ),
      ShortsModel(
        videoUrl:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        title: "Elephants Dream",
        description:
            "A surreal journey through a mechanical world filled with curious characters and wonders.",
        profileImage: AppImages.profile_image,
        episode: "2",
        season: "1",
        tags: ["Action", "Sci-Fi"],
      ),
      ShortsModel(
        videoUrl:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        title: "For Bigger Blazes",
        description:
            "Action-packed stunts and fire-breathing performances that will leave you breathless.",
        profileImage: AppImages.profile_image,
        episode: "3",
        season: "1",
        tags: ["Stunts", "Hot"],
      ),
      ShortsModel(
        videoUrl: "https://media.w3.org/2010/05/bunny/trailer.mp4",
        title: "For Bigger Escapes",
        description:
            "Thrill-seekers take on impossible challenges to escape from high-stakes situations.",
        profileImage: AppImages.profile_image,
        episode: "4",
        season: "1",
        tags: ["Thriller", "Action"],
      ),
      ShortsModel(
        videoUrl: "https://media.w3.org/2010/05/bunny/movie.mp4",
        title: "For Bigger Fun",
        description:
            "A lighthearted comedy about a group of friends who find humor in life's most unexpected moments.",
        profileImage: AppImages.profile_image,
        episode: "5",
        season: "1",
        tags: ["Comedy", "Fun"],
      ),
    ]);
  }

  void toggleEpisodePopup() {
    showEpisodePopup.value = !showEpisodePopup.value;
  }

  void changeEpisodeRange(String range) {
    selectedEpisodeRange.value = range;
  }

  List<int> get episodesForSelectedRange {
    final range = selectedEpisodeRange.value;
    if (range == "1-25") {
      return List.generate(25, (i) => i + 1);
    } else if (range == "26-43") {
      return List.generate(18, (i) => i + 26);
    } else if (range == "44-93") {
      return List.generate(50, (i) => i + 44);
    }
    return [];
  }

  void selectEpisode(int episode) {
    currentEpisode.value = episode;
    showEpisodePopup.value = false;
  }

  void toggleDescription() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
    print("Description expanded: ${isDescriptionExpanded.value}");
  }

  void updatePlaybackSpeed(String speed) {
    playbackSpeed.value = speed;
  }

  void updateVideoQuality(String quality) {
    videoQuality.value = quality;
  }

  void toggleFav() {
    isFav.value = !isFav.value;
    if (isFav.value) {
      showLoginPopup.value = true;
    }
  }

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
    if (isBookmarked.value) {
      showLoginPopup.value = true;
    }
  }

  void toggleLoginPopup() {
    showLoginPopup.value = !showLoginPopup.value;
  }

  void toggleMoreMenu() {
    showMoreMenu.value = !showMoreMenu.value;
  }

  void togglePip() {
    isPipEnabled.value = !isPipEnabled.value;
  }

  void toggleFullSeriesMode() {
    isFullSeriesMode.value = !isFullSeriesMode.value;
    try {
      final navController = Get.find<NavigationController>();
      navController.toggleBottomNav(!isFullSeriesMode.value);
    } catch (e) {
      // In case NavigationController is not found (e.g. direct screen load)
    }
  }

  void pauseCurrentVideo() {
    try {
      final videoUrl = shortsList[currentIndex.value].videoUrl;
      if (Get.isRegistered<ShortsVideoController>(tag: videoUrl)) {
        final videoController = Get.find<ShortsVideoController>(tag: videoUrl);
        videoController.pauseVideo();
      }
    } catch (e) {
      // Index out of range or controller not found
    }
  }

  void playCurrentVideo() {
    try {
      final videoUrl = shortsList[currentIndex.value].videoUrl;
      if (Get.isRegistered<ShortsVideoController>(tag: videoUrl)) {
        final videoController = Get.find<ShortsVideoController>(tag: videoUrl);
        videoController.playVideo();
      }
    } catch (e) {
      // Index out of range or controller not found
    }
  }

  void triggerPip() {
    if (shortsList.isNotEmpty) {
      final activeShort = shortsList[currentIndex.value];
      try {
        PipController.to.showPip(activeShort);
      } catch (e) {}
    }
  }

  void exitFullSeries() {
    triggerPip();
    pauseCurrentVideo(); // Pause before going back
    isFullSeriesMode.value = false;
    try {
      final navController = Get.find<NavigationController>();
      navController.toggleBottomNav(true);
    } catch (e) {
      // NavigationController not found
    }
    Get.back();
  }

  void showPlaybackSpeedBottomSheet(String videoUrl) {
    if (!Get.isRegistered<ShortsVideoController>(tag: videoUrl)) return;
    final videoController = Get.find<ShortsVideoController>(tag: videoUrl);
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: "Playback Speed",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            SizedBox(height: 20.h),
            ...speeds.map(
              (speed) => ListTile(
                title: Center(
                  child: Obx(
                    () => CustomText(
                      text: speed == 1.0 ? "Normal" : "${speed}x",
                      fontSize: 16.sp,
                      color: videoController.playbackSpeed.value == speed
                          ? AppColors.yellow100
                          : Colors.white,
                      fontWeight: videoController.playbackSpeed.value == speed
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                onTap: () {
                  videoController.setPlaybackSpeed(speed);
                  Get.back();
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
