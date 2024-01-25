//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    // MARK: Properties

    let isLoading: Bool

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        VStack {
            content

            if isLoading {
                progressView
            }
        }
    }

    // MARK: Private

    private var progressView: some View {
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            return ProgressView().progressViewStyle(.circular)
        }
        return EmptyView()
    }
}
