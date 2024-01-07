//
//  File.swift
//
//  ViewModel.swift
//  FindMyIP
//
//  Created by Kiran Kumar on 07/01/24.
//

import Foundation
import Alamofire
import Combine

@available(iOS 13.0, *)
class IPViewModel: ObservableObject {
    @Published var ipAddress: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchIPAddress() {
        isLoading = true
        
        AF.request("https://ipapi.co/json/")
            .validate()
            .publishDecodable(type: IPModel.self)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                if let ipModel = response.value {
                    self.ipAddress = ipModel.ip
                } else {
                    // Handle the case where the response value is nil
                    self.errorMessage = "Invalid response format"
                }
            }
            .store(in: &cancellables)
    }
}
