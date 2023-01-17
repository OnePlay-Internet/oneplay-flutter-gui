# Oneplay Flutter GUI

Introduction 
-------------------------
> This project is a starting point for a Graphical User Interface for [Oneplay Application](https://github.com/OnePlay-Internet/oneplayclient_android) as a module.

Requirement to build
-------------------------
  - [Flutter v3.3.10](https://docs.flutter.dev/development/tools/sdk/releases/) - Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase.
  - IDE - Integrated Development Environment
    1. [Visual Studio Code](https://code.visualstudio.com/)
    2. [Android Studio](https://developer.android.com/studio/) 
  - [Git](https://git-scm.com/download) - Git is a free and open source distributed version control system desgined to handle everything from small to very large projects with speed and efficiency.


Usage 
-------------------------
From your command line:

* Clone this repository
  * `git clone https://github.com/OnePlay-Internet/oneplay-flutter-gui.git`

* Go into the repository
  * `cd oneplay-flutter-gui`

* Create config env
  * Create config.dart into lib/app/common/config/
  * Define API_BASE_URL and CLIENT_API_BASE_URL

* Install dependencies
  * `flutter pub get`

* Run the app
  * `flutter run`

Notice:
-------------------------
If you want to run this project as an application, you must comment config module project in pubspec.yaml:
``` yaml
# module:
  #   androidX: true
  #   androidPackage: com.example.oneplay_flutter_gui
```
