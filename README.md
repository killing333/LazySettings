# LazySettings
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Save and load settings easily.

## Requirements
- iOS 9.0+
- Swift 3.0+

## Usage
### Create your own settings
By adopting the `LazySettingsModule` protocol, your own settings is ready!

### Add a settings module
```
let module = YourModule()
LazySettings.shared.add(module)
```

### Remove a settings module
```
LazySettings.shared.remove(module)
```

### Save all settings
```
LazySettings.shared.save()
```

### Load all settings from storage
```
LazySettings.shared.load()
```

## Installation
### Carthage
```
github "th1rt3en/LazySettings"
```
### Source
Drag all files in `Source` folder to your project
