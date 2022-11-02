//
//  Completions.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 26.10.2022.
//

import Foundation
import RealmSwift

typealias DecodableCallback<T: Decodable> = (Result<T?,Error>) -> Void
typealias ProductRateCallback = (Result<RateProductResult?, Error>) -> Void
typealias DictBoolableCallback = (Result<Dictionary<String,Bool>?, Error>) -> Void
typealias UserScoreCallback = (Result<UserScoreModel?, Error>) -> Void
typealias CouponCallback = (Result<CouponModel?, Error>) -> Void
typealias DictStringCallback = (Result<Dictionary<String,String>?, Error>) -> Void
