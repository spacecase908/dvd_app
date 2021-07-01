//
//  OmdbService.swift
//  MovieApp
//
//  Created by user194382 on 5/31/21.
//

import Foundation

enum OmdbCallingerror: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
    case problemEmptyReturn
}

class OmdbService {
    
    private let urlString = "https://run.mocky.io/v3/9b950378-d400-43bd-9a50-bad7313a86d0"
    

    func getFilms(completion: @escaping ([Film]?,Error?) -> ()) {
        guard let url = URL(string: self.urlString) else {
            DispatchQueue.main.async {
                completion(nil, FilmCallingerror.problemGeneratingURL)
            }
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, FilmCallingerror.problemGettingDataFromAPI)
                }
                return
            }
            do {
                let filmResult = try JSONDecoder().decode(FilmResult.self, from: data)

                DispatchQueue.main.async {
                    completion(filmResult.films,nil)
                }} catch (let error) {
                    print(error)
                    DispatchQueue.main.async {
                        completion(nil, FilmCallingerror.problemDecodingData)
                    }
            }
        }
        task.resume()
    }
    
}
