# Change Log
All notable changes to this project will be documented in this file.

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.1.0](#110)

## Unreleased

#### Changed
- Adopt Swift 6 language mode with strict concurrency (Swift 6.2 toolchain). Swift 6.0 uses Swift 6 mode, Swift 5.10 uses Swift 5 mode with `StrictConcurrency`.
- **Breaking:** public generics and loader/strategy protocols now require `Sendable` (`Element`, `State`, `Action`, `Request`, `ICursorPageLoader`, `IOffsetPageLoader`, `IPaginator`).
- Update `swift-composable-architecture` to 1.26.2 (Swift 6.1+). Older toolchains resolve an older compatible TCA.
- Minimum Swift toolchain is now 5.10 (`Package@swift-5.7.swift` and `Package@swift-5.8.swift` removed).

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
