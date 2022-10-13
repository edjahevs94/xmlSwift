//
//  SoapRequest.swift
//  SoapServiceConsumeExample
//
//  Created by EdgardVS on 5/10/22.
//

import Foundation
import Alamofire
import XMLMapper

struct Service {
    
    static let shared = Service()
    
    func getStringData(capitalCode: String, completion: @escaping (AFDataResponse<SoapEnvelopeResponse<SoapBodyResponse>>) -> ()) {
    
        
        let soapMessage = ServiceMessage(soapAction: "web:CapitalCity")
        soapMessage.countryCode = capitalCode
        let soapEnvelope = SoapEnvelope(soapMessage: soapMessage, envelopeParameter_1: "http://www.w3.org/2003/05/soap-envelope", envelopeParameter_2: "http://www.oorsprong.org/websamples.countryinfo")
        print(soapEnvelope.toXMLString() ?? "nil")
        
        AF.request("http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.default).responseXMLObject { (response : AFDataResponse<SoapEnvelopeResponse<SoapBodyResponse>>) in
            completion(response)
        }
        
        }

    class ServiceMessage: SoapMessage {

        var countryCode: String?

        override func mapping(map: XMLMap) {
            super.mapping(map: map)

            countryCode <- map["web:sCountryISOCode"]
        }
    }
    
    
    }

