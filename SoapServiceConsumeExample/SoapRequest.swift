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
    
    static func getStringData(parameters:[String:Any] = [:], completion: @escaping (Swift.Result<String, Error>) -> ()) {
    
       
        
        //print(soapEnvelope.toXMLString() ?? "nil")
        let soapMessage = ServiceMessage(soapAction: "web:CapitalCity")
        soapMessage.countryCode = "PE"
        let soapEnvelope = SoapEnvelope(soapMessage: soapMessage, envelopeParameter_1: "http://www.w3.org/2003/05/soap-envelope", envelopeParameter_2: "http://www.oorsprong.org/websamples.countryinfo")
        print(soapEnvelope.toXMLString() ?? "nil")
        
        AF.request("http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.default).responseString { response in
            switch response.result {
            case .success(let data):
             completion(.success(data))
            case .failure(let error):
             completion(.failure(error))
            }
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

