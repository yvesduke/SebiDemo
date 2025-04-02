# DrSebi Health App

A comprehensive iOS application focused on natural health and healing, inspired by Dr. Sebi's holistic approach to wellness. This app showcases different architectures and UI patterns in iOS development.

<img src="https://github.com/user-attachments/assets/cbc682da-3ebd-4284-b58e-0ce091b9bb17" alt="" width="250">


## Features

- **Foods Module**: SwiftUI interface with The Composable Architecture (TCA) pattern

  - Browse alkaline foods recommended by Dr. Sebi
  - View detailed information about each food
  - Clean, modern interface with state management

- **Herbs Module**: UIKit interface with MVVM + RxSwift pattern

  - Discover medicinal herbs and their benefits
  - Comprehensive information about healing herbs
  - Reactive UI updates using RxSwift/RxCocoa

- **Home Module**: Simple UIKit interface
  - Overview and introduction to Dr. Sebi's methodology
  - Navigation to main features

## Technical Overview

### Architecture

This project demonstrates multiple architectural approaches:

1. **The Composable Architecture (TCA)**

   - Used in the Foods module
   - State-driven UI with clear unidirectional data flow
   - Centralized state management
   - Testable components with dependency injection

2. **MVVM with RxSwift**

   - Used in the Herbs module
   - Reactive programming approach
   - Clear separation of concerns
   - Observable data streams

3. **Traditional UIKit**
   - Used in the Home module
   - Classic MVC pattern

### Dependencies

- **RxSwift/RxCocoa**: For reactive programming
- **The Composable Architecture**: For state management in SwiftUI
- **SwiftUI**: For modern declarative UI
- **UIKit**: For traditional UI components

## Getting Started

### Requirements

- iOS 16.4+
- Xcode 15.0+
- Swift 5.9+
- CocoaPods
