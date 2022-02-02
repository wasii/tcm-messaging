//
//  NetworkManager.swift
//  messaging-tcm
//
//  Created by Wasiq Saleem on 02/02/2022.
//

import Foundation
import UIKit

enum APIError: Error {
    case DecodingError
    case NoData
}
class NetworkManager: NSObject {
    let aPICalling:      APICalling
    let responseHandler: ResponseHandler
    
    init(aPICalling: APICalling = APICalling(),
         responseHandler: ResponseHandler = ResponseHandler()) {
        self.responseHandler = responseHandler
        self.aPICalling = aPICalling
    }
    
    func fetchData<T: Codable>(type: T.Type, onCompletion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = URL(string: FINALURL) else {
            return
        }
        self.aPICalling.callServer(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.handleResponse(type: type, data: data) { decoded in
                    switch decoded {
                    case .success(let model):
                        onCompletion(.success(model))
                    case .failure(_):
                        onCompletion(.failure(.DecodingError))
                    }
                }
                break
            case .failure(_):
                onCompletion(.failure(.NoData))
            }
        }
    }
}

class APICalling {
    func callServer(url: URL, onCompletion: @escaping(Result<Data, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return onCompletion(.failure(.NoData))
            }
            onCompletion(.success(data))
        }
    }
}

class ResponseHandler {
    func handleResponse<T:Codable>(type: T.Type, data: Data, onCompletion: @escaping(Result<T, APIError>) -> Void) {
        
        if let response = try? JSONDecoder().decode(type.self, from: data) {
            return onCompletion(.success(response))
        } else {
            return onCompletion(.failure(.DecodingError))
        }
    }
}
