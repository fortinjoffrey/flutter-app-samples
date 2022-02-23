# Better Flutter Starter App

A new Flutter project with additionnal starter features

## 📚 Features

- [x] Use of [Flutter Version Management](#fvm)
- [x] Enriched [analysis options](#analysisoptions)

<a name="fvm"/>

### ⚙️ Flutter version management

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

### ⚙️ Analysis options

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

