//
//  SoapBodyResponse.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 13/10/22.
//

import Foundation
import XMLMapper

class SoapBodyResponse: XMLMappable{
    
    var nodeName: String!

    var capitalResponse : CapitalResponse?

    required init?(map: XMLMap) {}

    func mapping(map: XMLMap) {
        capitalResponse <- map["m:CapitalCityResponse"]
    }
    
}
