import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortsVideoController extends GetxController {
  final String videoUrl;
  late VideoPlayerController videoPlayerController;

  var isInitialized = false.obs;
  var isPlaying = false.obs;
  var isError = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var playbackSpeed = 1.0.obs;
  var showPlayButton = true.obs;

  ShortsVideoController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  void _initialize() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) async {
        if (!isClosed) {
          isInitialized.value = true;
          duration.value = videoPlayerController.value.duration;
          videoPlayerController.setLooping(true);

          videoPlayerController.addListener(() {
            if (!isClosed && videoPlayerController.value.isInitialized) {
              position.value = videoPlayerController.value.position;
            }
          });

          // Auto-play after short delay — ShortsVideoPlayer will pause
          // non-active pages via ever(currentIndex)
          await Future.delayed(const Duration(milliseconds: 400));
          if (!isClosed && !videoPlayerController.value.isPlaying) {
            videoPlayerController.play();
            isPlaying.value = true;
            _startPlayButtonTimer();
          }
        }
      }).catchError((error) {
        if (!isClosed) isError.value = true;
      });
  }

  void _startPlayButtonTimer() {
    showPlayButton.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!isClosed && isPlaying.value) {
        showPlayButton.value = false;
      }
    });
  }

  void playVideo() {
    if (isClosed) return;
    if (videoPlayerController.value.isInitialized &&
        !videoPlayerController.value.isPlaying) {
      videoPlayerController.play();
      isPlaying.value = true;
      _startPlayButtonTimer();
    }
  }

  void pauseVideo() {
    if (isClosed) return;
    if (videoPlayerController.value.isInitialized &&
        videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isPlaying.value = false;
      showPlayButton.value = true;
    }
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      pauseVideo();
    } else {
      playVideo();
    }
  }

  void seekTo(Duration pos) {
    videoPlayerController.seekTo(pos);
    position.value = pos;
  }

  void setPlaybackSpeed(double speed) {
    videoPlayerController.setPlaybackSpeed(speed);
    playbackSpeed.value = speed;
  }

  @override
  void onClose() {
    pauseVideo();
    videoPlayerController.dispose();
    super.onClose();
  }
}