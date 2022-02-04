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
        
        self.getGUID()
    }
    private func getGUID() {
        guard let clientID = clientID,
              let clientSecret = clientSecret else {
            return
        }
        let params = [
            "clientId" : clientID,
            "secretKey" : clientSecret
        ]
        NetworkManager().fetchData(type: TokenModel.self, params: params) { result in
            switch result {
            case .success(let token_model):
                self.registerToken = token_model.returnStatus.tcmToken
                print(token_model.returnStatus.tcmToken)
                break
            case .failure(.NoData):
                break
            case .failure(.DecodingError):
                break
            }
        }
    }
}
