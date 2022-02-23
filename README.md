# Better Flutter Starter App

A new Flutter project with additionnal starter features

## 📚 Features

- [x] Use of [Flutter Version Management](#fvm)

<a name="fvm"/>

### ⚙️ Flutter version management

[FVM](https://fvm.app/) is a simple CLI to manage Flutter SDK versions.

It ensures that **every member of the team** will now use the **same flutter version** for this project

#### Prerequisites

- FVM installed
- A Flutter SDK version installed via FVM

#### FVM setup for project

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
