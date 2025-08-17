[![Pub Version](https://img.shields.io/pub/v/elevarm_icons?color=blueviolet)](https://pub.dev/packages/elevarm_icons)

Elevarm Icons for Flutter.

## Getting started

Use `elevarm_icons` together with [`elevarm_ui`](https://pub.dev/packages/elevarm_ui):

```dart
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_icons/elevarm_icons.dart';

ElevarmIcon(
    ElevarmIconsOutline.globe_01_education,
)
```

## Development

This section is intended for people that wants to develop `elevarm_icons` package.

### Getting Started

Follow instructions below to install this project on your machine.

1. Clone this repository to your machine.
2. Go inside the cloned repository:
   ```shell
   cd elevarm_icons
   ```
3. Setup local git hooks:
   ```shell
   dart run tool/setup_git_hooks.dart
   ```
4. Create `env.json` file by copying `env-example.json`:
   ```shell
   cp env-example.json env.json
   ```
5. Update all the values inside `env.json` with your own credentials.
6. Switch to `dev` branch:
   ```shell
   git checkout dev
   ```
7. Get all project dependencies:
   ```shell
   flutter pub get
   ```

## Additional information

Contact here: <a href="https://elevarm.com">elevarm.com</a>