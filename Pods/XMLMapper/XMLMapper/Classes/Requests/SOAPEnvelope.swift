//
//  SOAPEnvelope.swift
//  XMLMapper
//
//  Created by Giorgos Charitakis on 02/10/2017.
//

import Foundation

public class SOAPEnvelope: XMLMappable {
    public var nodeName: String! = "soap:Envelope"
    
    var soapEncodingStyle: String = "http://schemas.xmlsoap.org/soap/encoding/"
    var xmlnsSOAP: String = "http://schemas.xmlsoap.org/soap/envelope/"
    var soapBody: SOAPBody!
    var soapHeader: SOAPHeader?
    
    var nodesOrder: [String] = [
        "soap:Header",
        "soap:Body",
    ]
    
    public init(soapMessage: SOAPMessage, soapInformation: SOAPInformation? = nil, soapVersion: SOAPVersion = .version1point1) {
        xmlnsSOAP = "http://www.w3.org/2003/05/soap-envelope"
        soapEncodingStyle = "http://www.oorsprong.org/websamples.countryinfo"
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
