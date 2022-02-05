//
//  TCMServices.swift
//  messaging-tcm
//
//  Created by Wasiq Saleem on 02/02/2022.
//

import Foundation
import UIKit

class TCMServices: NSObject {
    
    var clientID:               String?
    var clientSecret:           String?
    
    private var GUID:           String?
    private var registerToken:  String?
    
    init(clientID: String, clientSecret: String) {
        super.init()
        self.clientID = clientID
        self.clientSecret = clientSecret
        
        self.getGUID { granted in
            if granted {
                self.registerUser()
            }
        }
    }
    private func getGUID(_ completion: @escaping (Bool)->()) {
        guard let clientID = clientID,
              let clientSecret = clientSecret else {
            return
        }
        let params = [
            "clientId" : clientID,
            "secretKey" : clientSecret
        ]
        NetworkManager().fetchData(url: REGISTERURL, requesttype: .post, type: TokenModel.self, params: params) { result in
            switch result {
            case .success(let token_model):
                self.registerToken = token_model.returnStatus.tcmToken
                completion(true)
                break
            case .failure(.NoData):
                break
            case .failure(.DecodingError):
                break
            }
        }
    }
    
    private func registerUser() {
        guard let registerToken = registerToken else {
            return
        }
        print(registerToken)
    }
}
