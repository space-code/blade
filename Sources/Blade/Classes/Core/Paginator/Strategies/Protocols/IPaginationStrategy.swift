//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol IPaginationStrategy<Element>: IPaginator where Element: Decodable & Equatable {}
