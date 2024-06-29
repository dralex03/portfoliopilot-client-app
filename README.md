# PortfolioPilot Frontend

PortfolioPilot Frontend is a Flutter application for managing and tracking your investment portfolios. It provides detailed information about your assets and visualizes their performance over time. This repository contains the front-end codebase.

## Table of Contents

- [PortfolioPilot Frontend](#portfoliopilot-frontend)
  - [Table of Contents](#table-of-contents)
  - [Prerequirements](#prerequirements)
      - [Installing Android Studio](#installing-android-studio)
      - [Installing Flutter](#installing-flutter)
  - [Installation](#installation)
  - [Usage](#usage)
  - [License](#license)

## Prerequirements

Flutter SDK and Android Studio need to be installed for the best experience while emulating the PortfolioPilot App.

#### Installing Android Studio
[Android Studio IDE](https://developer.android.com/studio?hl=de)

1. Download the latest version of Android Studio from the link above. Run the file you just downloaded.
2. Select both "Android Studio" and "Android Virtual Device" as components to install.
3. Open any Project in Android Studio and press `Ctrl`+`Alt`+`S` to open the project settings.
4. Head to `Languages & Frameworks` > `Android SDK`.
5. Make sure the `Android SDK Location` is set.
   1. If it's not set, click on `Edit` next to the field.
   2. Make sure `Android SDK` and `Android API` are selected.
   3. Click on `Next` twice.
   4. Accept all Licenses and click on `Next`.
   5. Wait for the installation to finish.
6. In the same settings tab (`Android SDK`) click on `SDK Tools`.
7. Make sure `Android SDK Command-line Tools` is checked. If the command-line tools are not installed, check the box and click on `Apply`. Android Studio will no install the command-line tools.
8. In the settings column on the left click on `Plugins` and search for `Flutter`. Install the Flutter Plugin.

#### Installing Flutter
[Flutter installation guide](https://flutter.dev/docs/get-started/install)
Installing the Flutter SDK is necessary, even if you already installed the Flutter Plugin for Android Studio.

1. Click on the link above and select your operating system.
2. Choose **"Android"** for your first type of app.
3. Scroll down to **"Install the Flutter SDK"** and make sure to select **"Download and install"** and not "Use VS Code to install".
4. Download the **latest stable release** and follow the official installation guide until the end. Make sure to add the Flutter SDK to your **PATH** and to create a virtual device.
5. Open a Terminal or Command Prompt and type `flutter doctor`.
Make sure that all listed elements have a green checkmark, except "Chrome" and "Visual Studio" as these are not required for Mobile Apps.
6. If one of the required elements do not have a green checkmark, go back to the official flutter installation guide for troubleshooting.



## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/dralex03/portfoliopilot-client-app.git
   cd portfoliopilot-frontend
2. Start Android Studio and open the repository you just cloned.
3. Create a .env file in the root directory with the following contents:
   ```
   API_URL=<BACKEND_API_URL>
4. Make sure Android Studio is configured correctly:
   1. Press `Ctrl`+`Alt`+`S` to open project settings.
   2. Head to "Languages & Frameworks" > "Flutter".
   3. Make sure the Flutter SDK path is selected. If it's not, click on "..." and navigate to the directory where you just installed the Flutter SDK.
   4. Next, click on "Dart" in the left column.
   5. Make sure the button at the top "Enabled Dart support for the project" is checked and the "Dart SDK Path" is set.
   6. If your Dart SDK Path is not set, navigate to the following path: `<your_flutter_sdk_path>/bin/cache/dart-sdk`.
   7. Under "Enable Dart support for the following modules" make sure that the portfoliopilot-client-app project is selected.
   8. Click on "OK" to apply the changes and exit the settings.
5. Install Dependencies by opening a terminal on the left at the bottom and type the following command: 
   ```sh
   flutter pub get
6. Click on "Device Manager" on right and start a virtual device from the list. If you don't have any virtual devices, add a new one.
7. Once the device has started, to select this device in the windowbar at the top.
8. Also make sure that next to the device selector, `main.dart` is selected.
9.  Finally, you can launch the app by clicking on the green play button.
   
   
## Usage
After installing and running the application, you can:
1. View your investment portfolios.
2. Check detailed information about each asset.
3. Track the performance of your investments over different periods (1 day, 1 week, 1 month, 1 year).

      
## License
**This project is licensed under the MIT License - see the LICENSE file for details.**
