# Change Log
All notable changes to this project will be documented in this file.

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.1.0](#110)

## Unreleased

#### Changed
- Adopt Swift 6 language mode with strict concurrency (Swift 6.2 toolchain; Swift 6.1 uses `Package@swift-6.1.swift`).
- **Breaking:** minimum Swift toolchain is now 6.1 (Xcode 16.3+). `Package@swift-5.7.swift` and `Package@swift-5.8.swift` removed.
- **Breaking:** update `swift-composable-architecture` to 1.26.2 (minimum version is now 1.26.2).
- **Breaking:** public generics and loader/strategy protocols now require `Sendable` (`Element`, `State`, `Action`, `Request`, `ICursorPageLoader`, `IOffsetPageLoader`, `IPaginator`).
- **Breaking:** `Reducer.paginator(...)` is only available when the parent reducer's `State` is `Sendable`.
- `CursorPaginatorState`, `PaginatorState` and `PaginatorAction` are `Sendable` when their identifiers are `Sendable`.

## [1.1.0](https://github.com/space-code/blade/releases/tag/1.1.0)
Released on 2024-08-26.

#### Added
- Integrate header and footer views into the list view.
  - Added in Pull Request [#3](https://github.com/space-code/blade/pull/3).

## [1.0.0](https://github.com/space-code/blade/releases/tag/1.0.0)
Released on 2024-02-05.

#### Added
- Initial release of Blade.
  - Added by [Nikita Vasilev](https://github.com/nik3212).
