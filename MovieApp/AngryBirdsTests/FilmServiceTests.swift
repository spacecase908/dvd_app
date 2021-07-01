//
//  FilmServiceTests.swift
//  MovieAppTests
//
//  Created by user194382 on 4/26/21.
//

import XCTest

@testable import MovieApp

class FilmServiceTests: XCTestCase {
    var systemUnderTest: FilmService!

    override func setUp() {
        self.systemUnderTest = FilmService()
    }

    override func tearDown() {
        self.systemUnderTest = nil
    }

    func testAPI_returnsSuccessfulResult() {
        
        //Given
        var films: [Film]!
        var error: Error!
        
        let promise = expectation(description: "Completion handler is invoked")
        
        //When
        self.systemUnderTest.getFilms(completion: { data, shouldntHappen in
            films = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        //Then
        XCTAssertNotNil(films)
        XCTAssertNil(error)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
