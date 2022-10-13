//
//  SoapEnvelope.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 7/10/22.
//

import Foundation
import XMLMapper

class SoapEnvelope: XMLMappable {
    public var nodeName: String! = "soap:Envelope"
    
    var soapEncodingStyle: String = "http://schemas.xmlsoap.org/soap/encoding/"
    var xmlnsSOAP: String = "http://schemas.xmlsoap.org/soap/envelope/"
    var soapBody: SOAPBody!
    var soapHeader: SOAPHeader?
    
    var nodesOrder: [String] = [
        "soap:Header",
        "soap:Body",
    ]
    
    public init(soapMessage: SoapMessage, soapInformation: SOAPInformation? = nil, envelopeParameter_1: String, envelopeParameter_2: String) {
        xmlnsSOAP = envelopeParameter_1
        soapEncodingStyle = envelopeParameter_2
        self.soapBody = SOAPBody(soapMessage: soapMessage)
        if let soapInformation = soapInformation {
            self.soapHeader = SOAPHeader(soapInformation: soapInformation)
        }
    }
    
    required public init?(map: XMLMap) {}
    
    public func mapping(map: XMLMap) {
        soapEncodingStyle <- map.attributes["xmlns:web"]
        xmlnsSOAP <- map.attributes["xmlns:soap"]
        soapHeader <- map["soap:Header"]
        soapBody <- map["soap:Body"]
        nodesOrder <- map.nodesOrder
    }
}
