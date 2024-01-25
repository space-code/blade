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
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}
