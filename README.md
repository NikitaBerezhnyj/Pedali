# Pedali

<p align="center">
  <img src="./assets/icon.png" alt="Pedali app logo" width="200"/>
</p>

Pedali is a local mobile app for tracking cycling rides.

It records your rides using GPS and keeps all data directly on your device. Track distance, speed, moving time, and other ride statistics without requiring an account or backend.

## Features

- **Ride tracking** — record your cycling rides with start, pause, resume, and stop controls.
- **Background tracking** — continue recording your ride while the app is in the background or the screen is turned off.
- **Live statistics** — view current speed, distance, moving time, and other ride information while cycling.
- **Ride history** — browse your previous rides and view their statistics.
- **Ride details** — see distance, moving time, elapsed time, average speed, and maximum speed.
- **Statistics** — track personal records and monthly cycling activity.
- **Local storage** — all ride data and GPS track points are stored locally on your device.
- **Privacy-focused** — no account or backend is required to use the app.

More features such as maps, GPX import/export, elevation data, and advanced ride analysis may be added in the future.

## Technologies

- [Flutter](https://flutter.dev/) — cross-platform mobile development.
- [Dart](https://dart.dev/) — programming language.
- [Riverpod](https://riverpod.dev/) — state management.
- [go_router](https://pub.dev/packages/go_router) — navigation.
- [Drift](https://drift.simonbinder.eu/) — type-safe SQLite database.
- [Geolocator](https://pub.dev/packages/geolocator) — GPS and background location tracking.

## Running the App

1. Install Flutter and Dart on your system:

   [Flutter installation guide](https://docs.flutter.dev/get-started/install)

2. Clone the repository:

```bash
git clone https://github.com/NikitaBerezhnyj/Pedali.git
cd Pedali
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run on an emulator or physical device:

```bash
flutter run
```

## License & Community Guidelines

- [GNU GPL v3 License](LICENSE) — project license.
- [Code of Conduct](CODE_OF_CONDUCT.md) — expected behavior for contributors.
- [Contributing Guide](CONTRIBUTING.md) — how to help the project.
- [Security Policy](SECURITY.md) — reporting security issues.
