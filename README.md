# Xpense

Xpense is a personal expense-tracking app for Android (for now), built with Flutter, giving a clear, at-a-glance view of money moving in and out of your accounts.

## Status

This is Sprint 1 of a multi-sprint roadmap. Sprint 1 delivers a runnable app showing a scrollable list of transactions and a computed balance summary, using hardcoded sample data (for now). Persistence, multiple accounts, and categories arrive will arrive later.

## Features (Sprint 1)

- Scrollable list of income and expense transactions, each showing description, category, date, and a colour-coded, signed amount.
- A balance header showing total money in, total money out, and net balance computed live from the transaction list.

## Running the app

1. Install the Flutter SDK ([flutter.dev](https://flutter.dev)) and confirm your setup with `flutter doctor`.
2. Clone this repository and run `flutter pub get`.
3. Connect an Android device (USB debugging enabled) or start an emulator.
4. Run `flutter run`.

## Running tests

- `flutter test` — unit tests on the `Transaction` model and a widget test on `TransactionListScreen`.
- `flutter analyze` — static analysis; the project is expected to stay clean.

## Architecture

The code is organized by layer, not by feature:

- `lib/models/` — plain Dart data (`Transaction`) and pure logic (the `TransactionSummary` extension). No Flutter imports; fully unit-testable in isolation.
- `lib/data/` — where transaction data comes from. Currently `sampleTransactions()`, a hardcoded stand-in; a later sprint replaces its implementation with a SQLite-backed repository without changing how the rest of the app calls it.
- `lib/widgets/` — small, reusable presentational widgets (`TransactionTile`, `BalanceSummary`).
- `lib/screens/` — full screens that compose the above (`TransactionListScreen`).

This separation means a future change to *where* data comes from only touches `lib/data/`.

![sprint_1_image](Screenshot_20260830_182949.jpg)