class GameSetting {
  String? gameId;
  String? resolution;
  bool? is_vsync_enabled;
  int? fps;
  double? bitrate;
  bool? show_stats;
  bool? fullscreen;
  bool? onscreen_controls;
  String? audio_type;
  String? stream_codec;
  String? video_decoder_selection;

  GameSetting({
    this.resolution,
    this.gameId,
    this.is_vsync_enabled,
    this.fps,
    this.bitrate,
    this.show_stats,
    this.fullscreen,
    this.onscreen_controls = false,
    this.audio_type,
    this.stream_codec,
    this.video_decoder_selection,
  });
}
