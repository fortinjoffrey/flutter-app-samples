# Clean architecture Weather Forecast App

## Demo

https://user-images.githubusercontent.com/36731875/157297949-585b079a-5f7e-45a3-aad7-4afbdf6c1aae.mp4

<a name="features"/>

## Features

- [x] Fake local auth (login, logout)
- [x] Persist login state
- [x] Search 5 days weather forecast for a given city
- [x] Pull to refresh weather forecast
- [x] Error handling
- [x] Redirection to home view when logged in

## 📝 Table of Contents

- [Features](#features)
- [How to build the app](#buildapp)
- [Todos](#todos)

<a name="buildapp"/>

## ⚙️ How to build the app

**2 options** are available:
1. [Flutter version manager setup](#fvmsetup) (recommended)
2. [Standard Flutter setup](#standardsetup)

<a name="fvmsetup"/>

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

<a name="standardsetup"/>

### Standard Flutter setup

##### 🔨 Prerequisites
- Flutter SDK version (see **"flutterSdkVersion"** in `.fvm/fvm_config.json`)

##### 📚 Steps
1. Download flutter app dependencies via `flutter pub get` command
2. Run the code generator via `flutter packages pub run build_runner build` command
3. Run the app via `flutter run` command

<a name="todos"/>

## 📖 TODOS

### Documentation
- Complete README with the following information:
  - What are code arch, code features, tests...

### Features
- Add Sign up page (to register username aswell)
- Add a debug FAB that will show modal containing options with switch to
  - simulate internet error
- Save user email, username, password in a local db

### Code

- Update validation usecases to return a ValidationResultType instead of unit
- Rethink error handling
  - Should the data layer redefine its own DataException ? Is it worth it ?
  - Enrich the Failure union with more domain failures. How much should the domain know about what happens in data ?
- Better handling of env var (local, staging, prod) (json config file)
- Better handling of API KEYS (json config file)
- Handling of multiple dio instaces for multiple sources

### Tests

- Add tests for weatherforecast api call
- Create a complete integration test from login to forecast fetching
