//
//  DayDetailsViewModel.swift
//  Forecast_MVVM
//
//  Created by Matthew Hill on 3/8/23.
//

import Foundation

protocol DayDetailsViewModelDelegate: AnyObject {
    func updateViews()
}

class DayDetailsViewModel {
    
    // MARK: - Properties
    var forecastData: TopLevelDictionary?
    var days: [Day] {
        forecastData?.days ?? []
    }
    
    private weak var delegate: DayDetailsViewModelDelegate?
    var service: ForecastServiceable
    
    init(delegate: DayDetailsViewModelDelegate, forecastServiceable: ForecastServiceable = ForecastService()){
        self.delegate = delegate
        self.service = forecastServiceable
        self.fetchForcastData()
    }
    
    // MARK: - Functions
        func fetchForcastData() {
            service.fetchDays(with: .cityForecast) { result in
            switch result {
                
            case .success(let success):
                self.forecastData = success
                self.delegate?.updateViews()
            case .failure(let error):
                print(NetworkError.thrownError(error))
            }
        }
    }
}
