//
//  FilmTest.swift
//  MovieAppTests
//
//  Created by user194382 on 4/26/21.
//

import XCTest
@testable import MovieApp
class FilmTest: XCTestCase {


    func testExample() throws {
        // Given
        let subjectUnderTest = Film(named: "That Movie",description: "So Good!", imageUrl: "https://tinyurl.com/yc8hwfx9", year: "2021")
        
        //When
        let actualValue = subjectUnderTest.debugDescription
        
        //Then
        let expectedValue = "Film(name: That Movie, description: So Good!, year: 2021)"
        XCTAssertEqual(actualValue, expectedValue)
        
    }



}
