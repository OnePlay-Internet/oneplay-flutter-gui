// ignore_for_file: constant_identifier_names

class PlayConstants {
  static const RESOLUTIONS = [
    "1280x720",
    "1920x1080",
    "2560x1440",
    "3840x2160",
  ];

  static const MOBILE_RESOLUTIONS = [
    "1280x720",
    "1920x1080",
  ];

  static const DEFAULT_RESOLUTIONS = {
    "Starter": "1280x720",
    "Founder": "1920x1080",
    "Elite": "1920x1080",
  };

  static const RESOLUTIONS_PACKAGES = {
    "Starter": ["1280x720"],
    "Founder": ["1280x720", "1920x1080", "2560x1440"],
    "Elite": [
      "1280x720",
      "1920x1080",
      "2560x1440",
      "3840x2160",
    ],
  };

  static const MAX_RESOLUTION_WIDTH = {
    "Starter": 1280,
    "Founder": 1920,
    "Elite": 3840,
  };

  static const FPS = [30, 60];

  static const DEFAULT_FPS = 60;

  static const VSYNC = [
    {
      "label": "Off",
      "value": false,
    },
    {
      "label": "On",
      "value": true,
    },
  ];

  static getIdleBitrate({required String resolution, int fps = 60}) {
    const b = {
      "1280x720": 10000,
      "1920x1080": 20000,
      "2560x1440": 40000,
      "3840x2160": 80000,
    };

    int bitrate = b[resolution]!.toInt();

    // if (bitrate === undefined) {
    //   if (screen.width >= 3840) {
    //     bitrate = 80000;
    //   } else if (screen.width >= 2560) {
    //     bitrate = 40000;
    //   } else if (screen.width >= 1366) {
    //     bitrate = 20000;
    //   } else if (screen.width >= 1024) {
    //     bitrate = 10000;
    //   } else if (screen.width >= 800) {
    //     bitrate = 5000;
    //   }
    // }

    return bitrate * (fps / 60);
  }
}
