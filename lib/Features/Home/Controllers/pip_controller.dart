import 'package:get/get.dart';
import 'package:uremz100/Features/Home/Views/Shorts/Model/shorts_model.dart';
import 'package:video_player/video_player.dart';

class PipController extends GetxController {
  static PipController get to => Get.find();

  final RxBool isPipVisible = false.obs;
  final Rx<ShortsModel?> currentShort = Rx<ShortsModel?>(null);

  VideoPlayerController? videoController;
  final RxBool isPlaying = false.obs;
  final RxBool isVideoInitialized = false.obs;

  void showPip(ShortsModel short) {
    currentShort.value = short;
    isPipVisible.value = true;

    // Initialize Video Player for the mini popup
    _initController(short.videoUrl);
  }

  Future<void> _initController(String url) async {
    await videoController?.dispose();
    isVideoInitialized.value = false;
    isPlaying.value = false;
    videoController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        videoController!.setLooping(true);
        videoController!.play();
        isPlaying.value = true;
        isVideoInitialized.value = true; // Triggers Obx to show video
      });
  }

  void togglePlay() {
    if (videoController != null) {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
        isPlaying.value = false;
      } else {
        videoController!.play();
        isPlaying.value = true;
      }
    }
  }

  void closePip() {
    isPipVisible.value = false;
    currentShort.value = null;
    videoController?.pause();
    videoController?.dispose();
    videoController = null;
    isPlaying.value = false;
    isVideoInitialized.value = false;
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
