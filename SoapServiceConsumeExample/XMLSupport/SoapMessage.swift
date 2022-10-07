//
//  SoapMessage.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 7/10/22.
//

import Foundation
import XMLMapper

class SoapMessage: XMLMappable {
    public var nodeName: String!
    
    private var xmlnsMessage: String?
    var soapAction: String?
    
    public init(soapAction: String) {
        self.soapAction = soapAction
        //self.xmlnsMessage = nameSpace
    }
    
    required public init?(map: XMLMap) {}
    
    open func mapping(map: XMLMap) {
        xmlnsMessage <- map.attributes["xmlns:"]
    }
}
