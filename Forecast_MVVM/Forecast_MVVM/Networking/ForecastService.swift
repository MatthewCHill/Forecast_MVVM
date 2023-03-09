//
//  ForecastService.swift
//  Forecast_MVVM
//
//  Created by Matthew Hill on 3/9/23.
//

import Foundation

protocol ForecastServiceable {
    func fetchDays(with endpoint: ForecastEndpoint, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void)
}

struct ForecastService: ForecastServiceable {
    let service = APIService()
    
     func fetchDays(with endpoint: ForecastEndpoint, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        guard let finalURL = endpoint.fullURL else {return}
        
        let request = URLRequest(url: finalURL)
         service.perform(request) { result in
             switch result {
                 
             case .success(let data):
                 do {
                     let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                     completion(.success(topLevelDictionary))
                 } catch {
                     print("Error in Do/Try/Catch: \(error.localizedDescription)")
                     completion(.failure(.unableToDecode))
                 }
             case .failure(let error):
                 completion(.failure(.thrownError(error)))
             }
         }
    }
}
