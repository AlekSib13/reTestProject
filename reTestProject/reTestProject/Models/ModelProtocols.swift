//
//  ModelProtocols.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol AnyProductModelProtocol {
    var id: Int {get}
    var productName: String {get}
    var productImage: String {get}
}
