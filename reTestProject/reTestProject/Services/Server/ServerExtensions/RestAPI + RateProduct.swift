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
    func sendRating<T: Encodable>(id: Int, dict: [String: T], callback: @escaping UserScoreCallback)
}

extension RestAPIService: RestRateProductProtocol {
    func getProductRate(offset: Int, limit: Int, callback:  @escaping ProductRateCallback) {
        let url = baseRestURL.appending(path: "/rate_product")
        let params: Parameters = ["offset": offset, "limit": limit]
        return makeDecodableRequestForData(url: url, params: params, callback: callback)
    }
    
    func sendRating<T: Encodable>(id: Int, dict: [String: T], callback: @escaping UserScoreCallback) {
        do {
            let encodedData = try endcode(data: dict)
            let url = baseRestURL.appending(path: "/rated")
            let params: Parameters = ["id": id]
            return makeDecodableRequestForData(url: url, method: .post, params: params, httpBody: encodedData, callback: callback)
        } catch {
            let error = BaseErrors(errorType: .encodingError, errorTitle: "EncodingError", descritpion: "Could not encode to required type")
            callback(.failure(error))
        }
    }
}
