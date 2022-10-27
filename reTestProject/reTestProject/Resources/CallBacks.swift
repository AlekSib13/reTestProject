//
//  Completions.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 26.10.2022.
//

import Foundation

typealias DecodableCallback<T: Decodable> = (Result<T?,Error>) -> Void
typealias ProductRateCallback = (Result<RateProductResult?, Error>) -> Void