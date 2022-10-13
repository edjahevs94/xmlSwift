//
//  CapitalResponse.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 13/10/22.
//

import Foundation
import XMLMapper

class CapitalResponse: XMLMappable {
    var nodeName: String!

    var name : String?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        name <- map["m:CapitalCityResult"]
    }
}
