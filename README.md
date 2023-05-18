# Nota
A flutter app to take notes

## Running the App
To run the app, you should fetch all dependencies

## App Architecture and Folder Structure

The code of the app implements clean architecture to separate the UI, domain and data layers with a feature-first approach for folder structure, implementing the MVVM architectural pattern.

#### Folder Structure

```
lib
├── core
│   ├── db
│   ├── model
│   ├── services
│   └── utilities
├── features
│   ├── all_notes
│   │   ├── utils
│   │   ├── widgets   
│   │   └── view
│   └── note_details
│       └── widget_tree
└── main.dart
```

* `main.dart` has the root `MaterialApp` and all necessary configurations and route settings to start the app
* The `core` folder contains code shared across features
    * `db` contains the code for the crud operations of the database.
    * `model` contains dart classes/models
    * `services`
    * `utilities` for colors, routing, fonts, and size management


* The `features` folder: contains the core features of the app like:
    * `all_notes` which contains code that displays all the notes if there are any
    * `note_details` code for a specific note

## Third party packages

- [Flutter screenutil](https://pub.dev/packages/flutter_screenutil): For adapting to different screen and font sizes to look good on different mobile screens.
- [sqflite](https://pub.dev/packages/sqflite): Preferred database plugin.
- [intl](https://pub.dev/packages/intl): For date time formatting.
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash): For a splash screen.
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter): For certain icons.
- [path](https://pub.dev/packages/path): It provides common operations for manipulating paths: joining, splitting, normalizing,
- [get_it](https://pub.dev/packages/get_it): A simple Service Locator.