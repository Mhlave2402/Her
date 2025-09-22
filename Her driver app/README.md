# ride_sharing_user_app

A ride sharing Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## SOS Button with Silent Alert

The "SOS Button with Silent Alert" feature allows drivers to send a silent alert to the admin panel in case of an emergency. The feature is implemented in the `lib/features/sos` directory.

### UI

The UI is implemented in the `lib/features/sos/screens/sos_screen.dart` file. It consists of a simple screen with a text field for a note and a "send" button.

### Logic

The business logic is implemented in the `lib/features/sos/controllers/sos_controller.dart` file. The controller gets the driver's current location and sends the SOS request to the backend.
