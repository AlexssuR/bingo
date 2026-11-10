# Bingo

Bingo is a Flutter web application for creating and playing Bingo cards. Players can add called numbers, create multiple Bingo cards, and manually mark matching numbers. A separate **Master page** provides a larger 10 × 9 progressive-number card for running the game.

## Features

- Add, remove, and clear called Bingo numbers.
- Create multiple Bingo cards in a scrollable grid.
- Choose how many cards to display per row.
- Manually mark numbers on each Bingo card.
- Prevent duplicate called numbers.
- Access a dedicated Master page with a 10 × 9 progressive-number Bingo card.
- Confirmation dialog before entering the Master page, since progress on the main page is not preserved.

## Screens

### Main page

The main page lets you:

- Enter called numbers and add them to the current game.
- Delete a specific number or clear all called numbers.
- Add Bingo cards.
- Remove the most recently added card.
- Change the number of cards shown per row, from 1 to 4.
- Mark numbers on individual cards.

### Master page

The Master page is intended for the person running the game. It includes a single large Bingo card with progressive numbers, alongside the same number-entry controls.

> WARNING: Navigating to the Master page discards the cards and numbers created on the main page.

## Project structure

```text
lib/
├── main.dart
├── main_page.dart
├── master_page.dart
├── grid_data.dart
└── components/
    ├── bingo_card.dart
    ├── bingo_card_options.dart
    └── number_selector.dart
```

## Requirements

- Flutter SDK
- A supported web browser, such as Chrome, Edge, Firefox, or Safari

## Getting started

1. Clone or download the project.

2. Install the project dependencies:

```bash
flutter pub get
```

3. Run the app in Chrome:

```bash
flutter run -d chrome
```

Flutter will build the app and open it in a new Chrome window. During development, `flutter run` uses debug mode, which enables hot reload and runtime assertions. [5]

### Run on another device

To see the available devices:

```bash
flutter devices
```

To run the app on the web without automatically launching a browser:

```bash
flutter run -d web-server
```

Flutter web apps can run in Chrome, Edge, Firefox, and Safari. [3]

## Building for production

Create an optimized web build with:

```bash
flutter build web
```

The generated files will be placed in the `build/web` directory.

You can also build using WebAssembly:

```bash
flutter build web --wasm
```

For local development or testing with WebAssembly, run:

```bash
flutter run -d chrome --wasm
```

Flutter supports compiling Dart web applications to both JavaScript and WebAssembly. [1][5]

## How to play

1. Open the app.
2. Enter a called number and press the add action.
3. Add one or more Bingo cards.
4. Mark the matching numbers on each card.
5. Use the card layout controls to display between 1 and 4 cards per row.
6. When you want to run the game from a larger board, select **Go to MasterPage** and confirm the warning.

## Notes

- The main page starts with a 3 × 9 Bingo card layout.
- The Master page starts with a 10 × 9 progressive-number Bingo card.
- Called numbers must be valid integers and cannot be added twice.
- The app currently stores game state in memory; refreshing the browser or leaving the main page will reset it.
