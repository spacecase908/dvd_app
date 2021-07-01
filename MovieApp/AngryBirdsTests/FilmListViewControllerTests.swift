//
//  FilmListViewControllerTests.swift
//  MovieAppTests
//
//  Created by user194382 on 4/27/21.
//

import XCTest
@testable import MovieApp
class FilmListViewControllerTests: XCTestCase {
    var systemUnderTest: MovieListViewController!
    

    override func setUpWithError() throws {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.systemUnderTest = navigationController.topViewController as? MovieListViewController
        
        UIApplication.shared.windows
            .filter { $0.isKeyWindow}
            .first!
            .rootViewController = self.systemUnderTest
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(self.systemUnderTest.view)
    }


    func testTableView_loadsBirds() throws {
        //Given
        let mockFilmService = MockFilmService()
        let mockFilms = [
            Film(named: "Mystery", description: "It's mysterious", imageUrl: "birds.com/angrycardinal", year: "2021"),
            Film(named: "Romance", description: "So romantic", imageUrl: "birds.com/angrycardinal", year: "2021"),
            Film(named: "Sci-Fi", description: "It's scientific", imageUrl: "birds.com/angrycardinal", year: "2021")
        ]
        mockFilmService.mockFilms = mockFilms
        
        self.systemUnderTest.viewDidLoad()
        self.systemUnderTest.filmService = mockFilmService
        
        XCTAssertEqual(0, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        //When
        self.systemUnderTest.viewWillAppear(false)
        
        
        //Then
        XCTAssertEqual(mockFilms.count, self.systemUnderTest.collection.count)
        XCTAssertEqual(mockFilms.count, self.systemUnderTest.tableView.numberOfRows(inSection: 0))
        
        
    }

    class MockFilmService: FilmService {
        var mockFilms: [Film]?
        var mockError: Error?
        
        override func getFilms(completion: @escaping ([Film]?, Error?) -> ()) {
            completion(mockFilms, mockError)
        }
    }

}
