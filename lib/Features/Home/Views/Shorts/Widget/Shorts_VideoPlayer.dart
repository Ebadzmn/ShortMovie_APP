import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uremz100/Utils/app_icons.dart';
import 'package:video_player/video_player.dart';
import '../Controller/Shorts_Controller.dart';
import '../Controller/Shorts_Video_Controller.dart';

class ShortsVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final int index;

  const ShortsVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.index,
  });

  @override
  State<ShortsVideoPlayer> createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<ShortsVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  late ShortsVideoController controller;
  Worker? _pageWorker;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Get or create the video controller for this URL
    controller = Get.put(
      ShortsVideoController(widget.videoUrl),
      tag: widget.videoUrl,
    );

    // Listen to page swipes: pause non-active, resume active
    try {
      final shortsController = Get.find<ShortsController>();
      _pageWorker = ever(shortsController.currentIndex, (idx) {
        if (controller.isClosed) return;
        if (idx == widget.index) {
          controller.playVideo();
        } else {
          controller.pauseVideo();
        }
      });
    } catch (_) {
      // ShortsController not found — auto-play from controller handles it
    }
  }

  @override
  void dispose() {
    _pageWorker?.dispose();
    Get.delete<ShortsVideoController>(tag: widget.videoUrl);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Obx(() {
      if (controller.isError.value) {
        return const Center(
          child: Icon(Icons.error, color: Colors.white, size: 40),
        );
      }

      if (!controller.isInitialized.value) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }

      return GestureDetector(
        onTap: () => controller.togglePlayPause(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.videoPlayerController.value.size.width,
                  height: controller.videoPlayerController.value.size.height,
                  child: VideoPlayer(controller.videoPlayerController),
                ),
              ),
            ),
            if (!controller.isPlaying.value)
              Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(28.r),
                child: SvgPicture.asset(
                  AppIcons.play_icon,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
