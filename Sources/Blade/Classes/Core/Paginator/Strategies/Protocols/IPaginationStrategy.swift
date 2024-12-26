//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol IPaginationStrategy<Element>: IPaginator, Sendable where Element: Decodable & Equatable {}
