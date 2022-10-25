//
//  ModelProtocols.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol AnyProductModelProtocol {
    var id: Int {get set}
    var productName: String {get set}
    var productImage: String {get set}
}
