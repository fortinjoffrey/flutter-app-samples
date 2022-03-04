# Better Flutter Starter App

A new Flutter project with additionnal starter features

## 📚 Features

- [x] Use of [Flutter Version Management](#fvm)
- [x] Enriched [analysis options](#analysisoptions)
- [x] VSCode [launch configurations](#vscodelaunchconfigurations)
- [x] Android Studio [launch configurations](#androidstudiolaunchconfigurations)
- [x] Use of [.editorconfig](#editorconfig)
- [x] Configure [git attributes](#gitattributes)

<a name="fvm"/>

## ⚙️ Flutter version management

[FVM](https://fvm.app/) is a simple CLI to manage Flutter SDK versions.

It ensures that **every member of the team** will now use the **same flutter version** for this project

#### Prerequisites

- FVM installed
- A Flutter SDK version installed via FVM

#### Setup

```bash
fvm use 2.10.1
```

A directory .fvm will be created containing 2 elements:
- **flutter_sdk** relative symlink that points to the used flutter version source code
- **fvm_config.json** that defines the Flutter SDK version

####  What to commit to git ?
- ✅ **fvm_config.json** to share the same Flutter SDK version between developpers
- ❌ **flutter_sdk**

Add this line to your project **.gitgnore** file
```.gitignore
.fvm/flutter_sdk
```

<a name="analysisoptions"/>

## ⚙️ Analysis options

New flutter project comes with **flutter_lints** dev dependencies that use a set of rules.

This package contains a recommended set of lints for Flutter apps, packages, and plugins to encourage good coding practices.

We will use the **lint** package to use a more severe set of rules.

We may want to be able to customise those rules and more.

#### Setup

1. Update **pubspec.yaml** file

Remove the **flutter_lints** package dependency and add the **lint** one

```yaml
dev_dependencies:
  flutter_lints: ^1.0.0    # remove this line
  lint: ^1.8.2             # add this line
```

2. Update **analysis_options.yaml** file
```yaml
include: package:lint/analysis_options.yaml

# Here customise analyser options and linter rules
```

Static analysis could be customised in this file.
See the official [documentation](https://dart.dev/guides/language/analysis-options)


<a name="vscodelaunchconfigurations"/>

## ⚙️ VSCode launch configurations

It is useful to create different launch configuration to quickly run a specific app or run the app in a specific build mode.

#### Setup

1. Go to the **Run & Debug** tab.
2. Tap on the "create a launch.json file" text button
3. Select "Dart & Flutter" environment

This will create a **launch.json** file inside **.vscode** in your project directory.

4. Write your configurations here

```json
"configurations": [
	{
		"name": "configuration name",
		"request": "launch",
		"type": "dart",
		"flutterMode": "debug"   # debug, release, profile
	},
]
```

<a name="androidstudiolaunchconfigurations"/>

## ⚙️ Android Studio launch configurations

It is useful to create different launch configuration to quickly run a specific app or run the app in a specific build mode.

#### Setup

1. Select **Edit configurations** button
2. Select **+** button to add new configuration
3. Select **Flutter**
4. Fill those fields:

- **Name**: your configuration name
- **Dart entrypoint**: the absolute path to your **main.dart** file
- **Additional run args**: —release (or —debug or —profile)

> Tip: tick the **Store as project file** checkbox to save your configurations, select the **store in .idea/runConfigurations** text button

This will create, for each configuration, an **XML** file inside **.idea/runConfigurations** in your project directory. 

5. Add gitignore exception for launch configurations

```text
.idea/*
!.idea/runConfigurations/
```

<a name="editorconfig"/>

## ⚙️ Editor config
The main goal of editor config is to override some IDEs options such as EOL, indent size...

#### Setup

##### VS Code

1. Install **EditorConfig for VS Code** extension
2. Right click on project explorer, then select **Generate .editorconfig** option

##### Android Studio

1. Install **EditorConfig** plugin
2. Right click on project explorer, select **New** and **EditorConfig file**

Write your custom editor config rules

[Here](https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties) is a complete list of available properties:

#### Usage

- For **VSCode**, **EditorConfig for VS Code** extension must be installed
- For **Android Studio**, **EditorConfig** plugin must be installed

<a name="gitattributes"/>

## ⚙️ Git attributes

A team of developers will often work on different OS like Windows, macOS or Linux.
Line endings differs between operating systems. Windows uses CRLF, macOS and Linux use LF.

We must ensure that git uses a unique way for line endings.
If not some files will be entirely marked as modified.

#### Setup

Git can actually be configured to automatically handle line endings using a setting called autocrlf.
However, we shouldn't rely on people having correctly configured Git installations.

The solution to this is to add a `.gitattributes` file at the root of our repository and set the line endings to be automatically normalised like so:

```
# Set default behavior to automatically normalize line endings to LF
* text=auto
```

