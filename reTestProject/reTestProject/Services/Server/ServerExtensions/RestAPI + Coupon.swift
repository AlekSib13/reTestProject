//
//  RestAPI + Coupon.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponProtocol {
    func getCoupon(callback: @escaping CouponCallback)
}

extension RestAPIService: CouponProtocol {
    func getCoupon(callback: @escaping CouponCallback) {
        let url = baseRestURL.appending(path: "/reward")
        return makeDecodableRequestForData(url: url, callback: callback)
    }
}
