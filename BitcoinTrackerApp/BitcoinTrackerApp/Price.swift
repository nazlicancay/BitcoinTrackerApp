//
//  Price.swift
//  BitcoinTrackerApp
//
//  Created by Nazlıcan Çay on 15.06.2022.
//

import Foundation

struct Rates : Codable{
    
    let rates : Currency
}

struct Currency :Codable {
    
    let btc : Price
    let eth : Price
    let usd : Price
    
}
struct Price :Codable{
    
    let name : String
    let unit : String
    let value : Float
    let type : String
}
