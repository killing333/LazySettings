# LazySettings

<!-- [![CI Status](http://img.shields.io/travis/killing333/LazySettings.svg?style=flat)](https://travis-ci.org/killing333/LazySettings) -->
[![Version](https://img.shields.io/cocoapods/v/LazySettings.svg?style=flat)](http://cocoapods.org/pods/LazySettings)
[![License](https://img.shields.io/cocoapods/l/LazySettings.svg?style=flat)](http://cocoapods.org/pods/LazySettings)
[![Platform](https://img.shields.io/cocoapods/p/LazySettings.svg?style=flat)](http://cocoapods.org/pods/LazySettings)

An organized way to save app settings to `NSUserDefaults`.

When `NSUserDefaults` is widely used in your source files, it would be hard to trace where your settings load and save. Thus an organized way has come up.

## How It Works

Break settings into module and follow the protocol `LazySettingsModule`, and add the module to shared instance of `LazySettings`. Now whenever `LazySettings` saves and loads, so do the modules.

`LazySettings` would occupy a key of the same name in `NSUserDefaults`.

For the implementation of a module, please refer to `LazySettingsGeneral` or `LazySettingsLanguage` as an example

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 8 or above

## Installation

LazySettings is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LazySettings"
```

## Author

killing333, hlwanhoj@gmail.com

## License

LazySettings is available under the MIT license. See the LICENSE file for more info.
