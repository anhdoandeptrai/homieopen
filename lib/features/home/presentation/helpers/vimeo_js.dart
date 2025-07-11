class VimeoJs {
  VimeoJs._();
  static String init(String videoId) => 'initVimeo("$videoId");';
  static const htmlPath = "assets/html/vimeo_player.html";
  static const getDuration = 'window.flutterVimeoPlayer.getDuration();';
  static const play = 'window.flutterVimeoPlayer.play();';
  static const pause = 'window.flutterVimeoPlayer.pause();';
  static const playPause = 'window.flutterVimeoPlayer.playPause();';
  static const getIsPaused = 'window.flutterVimeoPlayer.getIsPaused();';
  static const unmute = 'flutterVimeoPlayer.unmute();';
}
