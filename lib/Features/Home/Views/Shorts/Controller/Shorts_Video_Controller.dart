import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortsVideoController extends GetxController {
  final String videoUrl;
  VideoPlayerController? videoPlayerController;

  var isInitialized = false.obs;
  var isPlaying = false.obs;
  var hasStartedPlaying = false.obs;
  var hasError = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var playbackSpeed = 1.0.obs;
  var showPlayButton = true.obs;
  var isMuted = true.obs;
  var isLoading = false.obs;

  ShortsVideoController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    // Lazy initialization: Do nothing until initializeAndPlay is explicitly called
  }

  Future<void> initializeAndPlay() async {
    if (videoPlayerController != null) {
      if (!isPlaying.value) playVideo();
      return;
    }

    isLoading.value = true;
    hasStartedPlaying.value = true;
    String finalUrl = videoUrl.replaceFirst('http://', 'https://');
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(finalUrl));

    try {
      await videoPlayerController!.initialize();
      if (!isClosed) {
        isInitialized.value = true;
        duration.value = videoPlayerController!.value.duration;
        videoPlayerController!.setLooping(true);
        videoPlayerController!.setVolume(isMuted.value ? 0.0 : 1.0);

        videoPlayerController!.addListener(() {
          if (!isClosed && videoPlayerController!.value.hasError) {
            hasError.value = true;
          }
          if (!isClosed && videoPlayerController!.value.isInitialized) {
            position.value = videoPlayerController!.value.position;
          }
        });

        playVideo();
      }
    } catch (e) {
      if (!isClosed) hasError.value = true;
    } finally {
      if (!isClosed) isLoading.value = false;
    }
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
    if (isClosed || videoPlayerController == null) return;
    if (videoPlayerController!.value.isInitialized &&
        !videoPlayerController!.value.isPlaying) {
      videoPlayerController!.play();
      isPlaying.value = true;
      hasStartedPlaying.value = true;
      _startPlayButtonTimer();
    }
  }

  void pauseVideo() {
    if (isClosed || videoPlayerController == null) return;
    if (videoPlayerController!.value.isInitialized &&
        videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      isPlaying.value = false;
      showPlayButton.value = true;
    }
  }

  void togglePlayPause() {
    if (videoPlayerController == null) {
      initializeAndPlay();
      return;
    }
    if (videoPlayerController!.value.isPlaying) {
      pauseVideo();
    } else {
      playVideo();
    }
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    videoPlayerController?.setVolume(isMuted.value ? 0.0 : 1.0);
  }

  void seekTo(Duration pos) {
    videoPlayerController?.seekTo(pos);
    position.value = pos;
  }

  void seekBy(int seconds) {
    if (videoPlayerController == null) return;
    final newPos = position.value + Duration(seconds: seconds);
    final clampedPos = newPos.inMilliseconds < 0
        ? Duration.zero
        : newPos > duration.value
            ? duration.value
            : newPos;
    seekTo(clampedPos);
  }

  void setPlaybackSpeed(double speed) {
    videoPlayerController?.setPlaybackSpeed(speed);
    playbackSpeed.value = speed;
  }

  void disposeVideo() {
    videoPlayerController?.pause();
    videoPlayerController?.dispose();
    videoPlayerController = null;
    isInitialized.value = false;
    isPlaying.value = false;
    hasStartedPlaying.value = false;
    hasError.value = false;
    position.value = Duration.zero;
    duration.value = Duration.zero;
    isLoading.value = false;
  }

  @override
  void onClose() {
    disposeVideo();
    super.onClose();
  }
}