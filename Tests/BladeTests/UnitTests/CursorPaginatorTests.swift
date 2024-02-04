//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import XCTest

// MARK: - CursorPaginatorTests

final class CursorPaginatorTests: XCTestCase {
    // MARK: Properties

    private var pageLoaderMock: CursorPageLoaderMock<TestItem>!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        pageLoaderMock = CursorPageLoaderMock()
    }

    override func tearDown() {
        pageLoaderMock = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPaginatorLoadsNextPage() async throws {
        // given
        let sut = prepareSut()

        pageLoaderMock.stubbedLoadPage = .fake()

        // when
        _ = try await sut.loadNextPage()
        _ = try await sut.loadNextPage()

        // then
        var request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParametersList[0].request)
        XCTAssertEqual(request.id, .id)

        request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParametersList[1].request)
        XCTAssertNotEqual(request.id, .id)
    }

    func test_thatPaginatorRefreshesState() async throws {
        // given
        let sut = prepareSut()

        pageLoaderMock.stubbedLoadPage = .fake()

        // when
        _ = try await sut.refresh()

        // then
        let request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParameters?.request)
        XCTAssertEqual(request.id, .id)
    }

    func test_thatPagaginatorResetsState() async throws {
        // given
        let sut = prepareSut()

        pageLoaderMock.stubbedLoadPage = .fake()

        // when
        _ = try await sut.loadNextPage()
        await sut.reset()
        _ = try await sut.refresh()

        // then
        let request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParameters?.request)
        XCTAssertEqual(request.id, .id)
    }

    // MARK: Private

    private func prepareSut(id: UUID = .id) -> Paginator<TestItem> {
        Paginator<TestItem>(
            configuration: .init(id: id),
            cursorPageLoader: pageLoaderMock
        )
    }
}

// MARK: - Constants

private extension UUID {
    static let id = UUID()
}

private extension Page where T == TestItem {
    static func fake(numberOfItems: Int = 1, hasMoreData: Bool = true) -> Page<TestItem> {
        Page(
            items: Array(0 ..< numberOfItems).map { _ in TestItem(id: UUID()) },
            hasMoreData: hasMoreData
        )
    }
}
