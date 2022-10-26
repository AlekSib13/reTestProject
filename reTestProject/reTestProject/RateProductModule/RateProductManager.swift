//
//  RateProductManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductManagerProtocol {
    func getRateProducts(offset: Int, limit: Int, callback: @escaping ProductRateCallback)
}

class RateProductManager: RateProductManagerProtocol {
    
    let restService: RestRateProductProtocol
    
    init(restService: RestRateProductProtocol) {
        self.restService = restService
    }
    
    
    func getRateProducts(offset: Int, limit: Int, callback: @escaping ProductRateCallback) {
        //MARK: mock data
        let mockingData = [RateProductModel(id: 1, productName: "Apple iPhone X", productImage: "https://frankfurt.apollo.olxcdn.com/v1/files/l5mujft17b3f3-KZ/image;s=644x461", productRating: nil),
                           RateProductModel(id: 2, productName: "Sony PlayStation 4", productImage: "https://images.satu.kz/42583281_w640_h640_igrovaya-konsol-sony.jpg", productRating: nil, interestingInfo: "The same model was giving as a presenten to arab sheikh"),
                           RateProductModel(id: 3, productName: "GTA 5", productImage: "https://www.herni-svet.cz/wareImages/26/0/026042_or.jpg", productRating: nil, interestingInfo: "More the 100k items was sold on first weekend only in USA"),
                           RateProductModel(id: 4, productName: "Apple AirPods Pro", productImage: "https://ke-images.servicecdn.ru/ca3teb91ati1t4hjpmng/original.jpg", productRating: nil, interestingInfo: "Zzzzzzzzz - no, not only in this headphones"),
                           RateProductModel(id: 5, productName: "Xbox S", productImage: "https://sun9-53.userapi.com/impg/mkU--DM63gyz8DaKKSgOTgVmiHvFV5dcmeyfDQ/fyzp-30Ksbk.jpg?size=604x604&quality=96&sign=43d3c42730e2283958cccd7d6a5294de&type=album", productRating: nil),
                           RateProductModel(id: 6, productName: "Nintendo Switch", productImage: "https://sun9-88.userapi.com/impg/7NjUvxcYanWKtTMWQhherXWlD3-ZpYmNv2d4pw/404VVfi9Xzg.jpg?size=604x604&quality=96&sign=1ac7f883739c0b565ecaac59182af03b&type=album", productRating: nil),
                           RateProductModel(id: 7, productName: "Apple iPhone 13 Pro", productImage: "https://static.chotot.com/storage/chotot-kinhnghiem/c2c/2021/09/08d1bfbc-iphone-13-pro-max-gia-bao-nhieu-anh-dai-dien.jpg", productRating: nil),
                           RateProductModel(id: 8, productName: "Jurassic World", productImage: "https://bargainbabe.com/wp-content/uploads/2016/01/Screen-Shot-2016-01-30-at-11.46.58-AM-512x640.png", productRating: nil),
                           RateProductModel(id: 9, productName: "James Bond", productImage: "https://i.pinimg.com/originals/d2/d7/2b/d2d72b3fe5a502c471f5472125248e91.jpg", productRating: nil),
                           RateProductModel(id: 10, productName: "Top gun", productImage: "https://target.scene7.com/is/image/Target/GUEST_838b5b53-84af-4c0f-99e8-cb3e161d9fc3?wid=500&hei=500", productRating: nil)
        ]
        callback(.success(mockingData))
        //TODO: uncomment for API requests and hide mock data
//        restService.getProductRate(offset: offset, limit: limit, callback: callback)
    }
}
