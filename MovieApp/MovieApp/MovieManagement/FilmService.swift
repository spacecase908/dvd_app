//
//  BirdService.swift
//  AngryBirds
//
//  Created by user194382 on 4/8/21.
//

import Foundation

enum FilmCallingerror: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
    case problemEmptyReturn
}

class FilmService {
    
    private let urlString = "https://run.mocky.io/v3/d22df902-2102-419f-813d-44f8b3031de5"
    
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
