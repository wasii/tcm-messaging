//
//  TCMServices.swift
//  messaging-tcm
//
//  Created by Wasiq Saleem on 02/02/2022.
//

import Foundation
import UIKit

typealias tcm_token = ()->()
class TCMServices: NSObject {
    var clientID:       String?
    var clientSecret:   String?
    
    init(clientID: String, clientSecret: String) {
        super.init()
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.getToken {}
    }
    
    fileprivate func getToken(completion: tcm_token) {
        guard let clientID = clientID,
              let clientSecret = clientSecret else {
            return
        }
        print(clientID)
        print(clientSecret)
        
        NetworkManager().fetchData(type: Model.self) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
