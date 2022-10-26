//
//  RestAPI + RateProduct.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import Alamofire

protocol RestRateProductProtocol {
    func getProductRate(offset: Int, limit: Int, callback: @escaping ProductRateCallback)
}

extension RestAPIService: RestRateProductProtocol {
    func getProductRate(offset: Int, limit: Int, callback:  @escaping ProductRateCallback) {
        let url = baseRestURL.appending(path: "/rate_product")
        let params: Parameters = ["offset": offset, "limit": limit]
        return makeRequestForData(url: url, params: params, callback: callback)
    }
}
