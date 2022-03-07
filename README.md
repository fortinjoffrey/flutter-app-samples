# Clean architecture Weather Forecast App

<a name="features"/>

## Features

- [x] Fake local auth (login, logout)
- [x] Persist login state
- [x] 5 days weather forecast for Paris
- [x] Redirection to home view when logged in

## 📝 Table of Contents

- [Features](#features)
- [How to build the app](#buildapp)
- [Todos](#todos)

<a name="buildapp"/>

## ⚙️ How to build the app

**2 options** are available:
1. Flutter version manager setup (recommended)
2. Standard Flutter setup

### Flutter version manager setup (recommended)

FVM ([flutter version manager](https://fvm.app/)) is a simple CLI to manage Flutter SDK versions.
Each flutter project can now use its own flutter version.
It also ensures that all developers are working with the same flutter version.

##### 🔨 Prerequisites
- FVM installed
- Run `fvm install` to install the current active flutter version used in project

##### 📚 Steps
1. Download flutter app dependencies via `fvm flutter pub get` command
2. Run the code generator via `fvm flutter packages pub run build_runner build` command
3. Run the app via `fvm flutter run` command

***1st tip***: a *makefile* has been created to perform these commands (simply call **make all** command)
***2nd tip***: in *.zshrc* or *.bashrc* (depending on your shell) use this alias **alias f="fvm flutter"**

⚠️ If you use an IDE for flutter commands, make sure that you IDE use the fvm flutter version
- FVM configuration for [VS Code](https://fvm.app/docs/getting_started/configuration#vs-code)
- FVM configuration for [Android Studio](https://fvm.app/docs/getting_started/configuration#android-studio)

---
### Standard Flutter setup

##### 🔨 Prerequisites
- Flutter SDK version (see **"flutterSdkVersion"** in `.fvm/fvm_config.json`)

##### 📚 Steps
1. Download flutter app dependencies via `flutter pub get` command
2. Run the code generator via `flutter packages pub run build_runner build` command
3. Run the app via `flutter run` command

<a name="todos"/>

## 📖 TODOS

- Complete README with the following information:
  - What are code arch, code features, tests...
- Rethink error handling
  - Should the data layer redefine its own DataException ? Is it worth it ?
  - Enrich the Failure union with more domain failures. How much should the domain know about what happens in data ?
- Add Sign up page (to register username aswell)
- Better handling of env var (local, staging, prod) (json config file)
- Better handling of API KEYS (json config file)
- Handling of multiple dio instaces for multiple sources
