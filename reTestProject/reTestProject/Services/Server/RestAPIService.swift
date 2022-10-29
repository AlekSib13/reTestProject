//
//  RestApiService.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import Alamofire

protocol RestAPIServiceProtocol {
    func makeDecodableRequestForData<T: Decodable>(url: URL, method: HTTPMethod, params: Parameters?, httpBody: Data?, callback: @escaping DecodableCallback<T>)
    func getHeaders() -> HTTPHeaders
}

class RestAPIService: RestAPIServiceProtocol {
  
    static let shared = RestAPIService()
    private init() {}
    
    let decodingQueue = DispatchQueue(label: "decodingQueue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    var defaultHeaders: HTTPHeaders {
        let headers: HTTPHeaders = ["platform": "iOS", "timezone": "\(String(TimeZone.current.secondsFromGMT() / 3600))"]
        return headers
    }
    
    let baseRestURL = BaseURL.baseUrl.url!
    
    func getHeaders() -> HTTPHeaders {
        //add token
        return defaultHeaders
    }
    
    
    func makeDecodableRequestForData<T>(url: URL, method: HTTPMethod = .get, params: Parameters? = nil, httpBody: Data? = nil,  callback: @escaping DecodableCallback<T>) where T : Decodable {
        
        var request = try! URLRequest(url: url, method: method, headers: getHeaders())
        
        if let httpBody {
            request.httpBody = httpBody
        }
        
        request = try! URLEncoding(boolEncoding: .literal).encode(request, with: params)
        
        AF.request(request).validate().response(queue: decodingQueue) {[weak self] response in
            guard let self = self else {return}
            switch response.result {
            case .success(let data):
                if let data {
                    self.decode(data: data, callback: callback)
                } else {
                    DispatchQueue.main.async {
                        callback(.success(nil))
                    }
                }
            case .failure(let error):
                let serverError = BaseErrors(errorType: .serverError, errorTitle: error.localizedDescription, descritpion: nil)
                DispatchQueue.main.async {
                    callback(.failure(serverError))
                }
            }
        }
    }
    
    private func decode<T: Decodable> (data: Data, callback: @escaping DecodableCallback<T>) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                callback(.success(result))
            }
        } catch {
            let decodingError = BaseErrors(errorType: .decodingError, errorTitle: "Decoding error", descritpion: "Could not decode to required type")
            DispatchQueue.main.async {
                callback(.failure(decodingError))
            }
        }
    }
    
    
    func endcode<T: Encodable>(data: T) throws -> Data {
        try JSONEncoder().encode(data)
    }
}
