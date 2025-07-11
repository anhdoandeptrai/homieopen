class EndpointConstants {
  EndpointConstants._();
  // Authen
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // User
  static const String getUser = '/auth';

  // Video
  static const String getRecommendedVideos = '/videos/recommendation';
  static const String getShortVideos = '/videos/shorts';
  static const String getLongVideos = '/videos/series';

  //Interactive
    static const String likeVideo = '/videos/like';
    static const String saveVideoWatching = '/videos/watch';
    static const String comment = '/comments';

}
