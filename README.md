# 🔴 Pokedex

A Pokédex app built with SwiftUI and Clean Architecture principles. The app fetches Pokémon data from a remote API.

## 📲 Setup

Guide to setup and run the project.

- Install Xcode (version 16.4 is recommended)
- Clone project in your mac
- Open 'Pokedex.xcodeproj' file with Xcode previous dowloaded
- Select an iPhone or iPad device
- Select the 'Pokedex' scheme
- Click 'Run' scheme

## 🏛️ Architectural Overview

The project follows **Clean Architecture**, **MVVM** and **Builder**.

### Layers

[View] -> [ViewModel] -> [UseCase] -> [Repository] -> [NetworkService]
  
- **View**
    - Display data provided by ViewModel
    - Use `@ObservedObject` to listen to ViewModel changes
    - `LoadingState` is a enum used to state management
    
- **ViewModel**
    - Calls UseCase to get data
    - Format data to provide to View

- **UseCase**
    - Validate received data from Repository
    - Encapsulate business logic
    
- **Repository**
    - Transform raw data to domain entities
    - Request data from NetworkService
    
- **NetworkService**
    - Make RESTful API requests

## 💡 Decision Discussion

### Technology choices
- **SwiftUI**
    - Modern framework seems good to create a new project from zero, because will have support for a longer period.
    - Declarative UI makes it faster to build new views, especially if it is a prototype, as is the case.
    
- **async/wait**
    - Cleaner syntax, easier to read and maintain, being very good to simple projects
 
- **XCTest**
    - Native lib and very complete with all things I would need to create good tests
    - Trade-off: Third-party frameworks like Quick and Nimble Could have been used, which are more readable, but because the app is simple and many reading problems can be solved with good organization I preferred to use XCTest.

### Architecture
- **MVVM**
    - Chosen for better separation of concerns and testability. 
    - Very good with SwiftUI declarative programming.
    - Because of being simple project and fast development MVVM seemed to be a medium choice, not as confusing as MVC, but not as slow as Clean Swift.

- **Builder**
    - I chose this pattern to separate the depency injection into a struct that is the only responsable for it.

## 🛠️ Libraries and tools

I chose using only native libraries and tools, because I didn't see the need to add more dependencies using SPM.

## ⏳ Things I would do with more time
- Add cache to images request.
- Add a security layer for requests like certificate pinning.
- Add SwiftLint.
- Add mock environment to be able to use the app even offline to help in development and tests.
- Add images of pokemon types in DetailsView.
- Different error screen for each feature.
