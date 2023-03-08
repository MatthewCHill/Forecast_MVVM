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
    
    private let networkingController: NetworkingContoller
    
    init(delegate: DayDetailsViewModelDelegate, networkingController: NetworkingContoller = NetworkingContoller()){
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForcastData()
    }
    
    // MARK: - Functions
    private func fetchForcastData() {
        NetworkingContoller.fetchDays { result in
            switch result {
                
            case .success(let success):
                self.forecastData = success
                self.delegate?.updateViews()
            case .failure(let error):
                print(error.errorDescription ?? "Unkown Error")
            }
        }
    }
}
