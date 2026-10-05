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
        Group {
            content

            if isLoading {
                progressView
            }
        }
    }

    // MARK: Private

    private var progressView: some View {
        ProgressView().progressViewStyle(.circular)
    }
}
