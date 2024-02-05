![Blade: a pagination framework that simplifies the integration of pagination into the application](https://raw.githubusercontent.com/space-code/blade/dev/Resources/blade.png)

<h1 align="center" style="margin-top: 0px;">blade</h1>

<p align="center">
  <a href="https://github.com/space-code/blade/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/space-code/blade?style=flat"></a> 
  <a href="https://swiftpackageindex.com/space-code/blade"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fblade%2Fbadge%3Ftype%3Dswift-versions"/></a> 
  <a href="https://swiftpackageindex.com/space-code/blade"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fblade%2Fbadge%3Ftype%3Dplatforms"/></a> 
  <a href="https://github.com/space-code/blade"><img alt="CI" src="https://github.com/space-code/Blade/actions/workflows/ci.yml/badge.svg?branch=main"></a>
  <a href="https://codecov.io/gh/space-code/blade"><img alt="CodeCov" src="https://codecov.io/gh/space-code/flare/graph/badge.svg?token=0N0jMJnozP"></a>
  <br>
  <br>
  <a href="https://github.com/space-code/blade"><img alt="Number of GitHub contributors" src="https://img.shields.io/github/issues/space-code/blade"></a>
  <a href="https://github.com/space-code/blade"><img alt="Number of GitHub issues that are open" src="https://img.shields.io/github/stars/space-code/blade"></a>
  <a href="https://github.com/space-code/blade"><img alt="Number of GitHub closed issues" src="https://img.shields.io/github/issues-closed/space-code/blade"></a>
  <a href="https://github.com/space-code/blade"><img alt="Number of GitHub stars" src="https://img.shields.io/github/contributors/space-code/blade"></a>
  <a href="https://github.com/space-code/blade"><img alt="Number of GitHub pull requests that are open" src="https://img.shields.io/github/issues-pr-raw/space-code/blade"></a>
  <br>
  <br>
  <a href="https://github.com/space-code/blade"><img alt="GitHub release; latest by date" src="https://img.shields.io/github/v/release/space-code/blade"></a>
  <a href="https://github.com/apple/swift-package-manager" alt="blade on Swift Package Manager" title="blade on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
</p>

## Description
`Blade` is a pagination framework that simplifies the integration of pagination into the application.

- [Usage](#usage)
- [Requirements](#requirements)
- [Installation](#installation)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Usage

Blade provides two libraries for working with pagination: `Blade` and `BladeTCA`. `BladeTCA` is an extension designed for working with [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture). Both support working with offset and cursor-based paginations.

### Basic Usage

First, you need to implement page loader for whether cursor or offset based pagination:

```swift
import Blade

/// Offset pagination loader

final class OffsetPageLoader<Element: Equatable & Decodable>: IOffsetPageLoader {
  func loadPage(request: OffsetPaginationRequest) async throws -> Page<Element> {
    // Implementation here
  }
}

/// Cursor pagination loader

final class CursorPageLoader<Element: Equatable & Decodable & Identifiable>: ICursorPageLoader {
  func loadPage(request: CursorPaginationRequest<Element>) async throws -> Page<Element> {
    // Implementation here
  }
}
```

Second, create a `Paginator` instance:

```swift
import Blade

/// Offset-based pagination
let paginator = Paginator(configuration: PaginationLimitOffset(firstPage: .zero, limit: 20), offsetPageLoader: OffsetPageLoader())

/// Cursor-based pagination
let paginator = Paginator(configuration: PaginationCursorSeek(id: #id_here), offsetPageLoader: CursorPageLoader())
```

Third, the paginator is capable of requesting the first page, the next page, and resetting its state, like this:

```swift
/// Request an initial page
let page = try await paginator.refresh()

/// Request next page
let nextPage = try await paginator.nextPage()

/// Reset state
await paginator.reset()
```

### TCA Usage

If your app uses the [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture), `Blade` can be easily integrated. 

```swift
import BladeTCA

// MARK: Reducer

@Reducer
struct SomeFeature {
    // MARK: Types

    struct State: Equatable {
        var paginator: PaginatorState<ArticleView.ViewModel>
    }

    enum Action {
        case child(PaginatorAction<ArticleView.ViewModel, Never>)
    }

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in 
          switch state {
            case .clild:
              return .none
          }
        }
        .paginator(
            state: \SomeFeature.State.paginator,
            action: /SomeFeature.Action.child,
            loadPage: { request, state in
                // Load page here
            }
        )
    }
}

// MARK: View

import ComposableArchitecture
import DesignKit
import SwiftUI

// MARK: - SomeView

struct SomeView: View {
    // MARK: Properties

    private let store: StoreOf<SomeFeature>

    // MARK: Initialization

    init(store: StoreOf<SomeFeature>) {
        self.store = store
    }

    // MARK: View

    var body: some View {
      PaginatorListView(
        store: store.scope(state: \.paginator, action: { .child($0) })
      ) { state in 
        // Implement UI here
      }
    }
```

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 7.0+ / visionOS 1.0+
- Xcode 15.0
- Swift 5.7

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but `blade` does support its use on supported platforms.

Once you have your Swift package set up, adding `blade` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/space-code/blade.git", .upToNextMajor(from: "1.0.0"))
]
```

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
blade is available under the MIT license. See the LICENSE file for more info.
