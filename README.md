# ayiconnect_web

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build the release version of web

#### Open terminal in your project folder then type `flutter build web`.
##### Because i use fvm (flutter version manager for this project), so the command is:
`fvm flutter build web`

This creates and places the app and the assets files in the /build/web directory as you can see the build files under the/build/web folder.

after that just need to copy and paste the files inside `build/web` to the hosting provider.

##*DISCLAIMER*
Sometimes the local assets are build in wrong path inside the `build/web/assets/ folder.
Just need to change the correct path if this happened.
