//
//  SoapHeader.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 7/10/22.
//


import Foundation
import XMLMapper

class SOAPHeader: XMLMappable {
    public var nodeName: String!
    
    var soapInformation: SOAPInformation?
    
    private var informationName: String?
    
    init(soapInformation: SOAPInformation) {
        self.informationName = soapInformation.informationName
        self.soapInformation = soapInformation
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapInformation <- map[(informationName ?? "")]
    }
}
