# Flight Search App

A Flutter flight search application built for the interview task. The app lets users select departure and arrival airports, choose trip details, and view matching flight search results.

## Submission Links

- Screen recording: https://drive.google.com/file/d/1ApMJFTPNWtPv_2StJRl5VQJK_g6GXBH8/view?usp=sharing
- APK file: https://drive.google.com/file/d/1BUG1KqXFFuH2i-ph8Dw8cXvMDYMdssmV/view?usp=drive_link

## What Is Done

- Built an airport search screen with a dark themed flight search card.
- Loaded airport data from a remote JSON endpoint.
- Added searchable airport selection for departure and arrival.
- Added airport swapping between departure and arrival.
- Added trip type selection for one way and round way.
- Added departure and return date selection behavior.
- Added traveler count and cabin class.
- Added validation before starting a flight search.
- Built a flight results screen.
- Loaded flight data from a remote JSON endpoint.
- Filtered flight results by selected departure and arrival airport codes.
- Displayed best flights and other departing flights separately.
- Added expandable flight result cards.
- Added price insights display when available.
- Added empty, loading, retry, and error states.

## Tech Stack

- Flutter
- Dart
- GetX for state management and routing
- HTTP package for API calls

## Project Structure

```text
lib/
  core/
    common/
    endpoints/
  features/
    airport_search/
    flight_search/
```

## API Data

The app currently reads data from remote JSON endpoints:

- Airport data: configured in `lib/core/endpoints/endpoints.dart`
- Flight search data: configured in `lib/core/endpoints/endpoints.dart`

## How To Run

```bash
flutter pub get
flutter run
```

## Build APK

```bash
flutter build apk --release
```

The generated APK will be available at:

```text
build/app/outputs/flutter-apk/app-release.apk
```
