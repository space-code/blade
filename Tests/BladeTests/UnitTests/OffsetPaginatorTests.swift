//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import XCTest

// MARK: - OffsetPaginatorTests

final class OffsetPaginatorTests: XCTestCase {
    // MARK: Properties

    private var pageLoaderMock: OffsetPageLoaderMock<TestItem>!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        pageLoaderMock = OffsetPageLoaderMock()
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
        XCTAssertEqual(request.offset, .limit)
        XCTAssertEqual(request.limit, .limit)

        request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParametersList[1].request)
        XCTAssertEqual(request.offset, 2 * .limit)
        XCTAssertEqual(request.limit, .limit)

//        let count = await sut.elements.count
//        XCTAssertEqual(count, 2 * .limit)
    }

    func test_thatPaginatorRefreshesState() async throws {
        // given
        let sut = prepareSut()

        pageLoaderMock.stubbedLoadPage = .fake()

        // when
        _ = try await sut.refresh()

        // then
        let request = try XCTUnwrap(pageLoaderMock.invokedLoadPageParameters?.request)
        XCTAssertEqual(request.offset, .zero)
        XCTAssertEqual(request.limit, .limit)
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
        XCTAssertEqual(request.offset, .zero)
        XCTAssertEqual(request.limit, .limit)
    }

    // MARK: Private

    private func prepareSut(firstPage: Int = .zero, limit: Int = .limit) -> Paginator<TestItem> {
        Paginator<TestItem>(
            configuration: .init(firstPage: firstPage, limit: limit),
            offsetPageLoader: pageLoaderMock
        )
    }
}

// MARK: - Constants

private extension Int {
    static let limit = 10
}

private extension Page where T == TestItem {
    static func fake(numberOfItems: Int = 1, offset: Int = .zero, hasMoreData: Bool = true) -> Page<TestItem> {
        Page(
            items: Array(0 ..< numberOfItems).map { _ in TestItem(id: UUID()) },
            offset: offset,
            hasMoreData: hasMoreData
        )
    }
}
