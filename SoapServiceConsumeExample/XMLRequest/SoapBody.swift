//
//  SoapBody.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 7/10/22.
//

import Foundation

import Foundation
import XMLMapper

public class SOAPBody: XMLMappable {
    public var nodeName: String!
    
    var soapMessage: SoapMessage?
    
    private var soapAction: String?
    
    init(soapMessage: SoapMessage) {
        self.soapAction = soapMessage.soapAction
        self.soapMessage = soapMessage
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapMessage <- map[(soapAction ?? "")]
    }
}
