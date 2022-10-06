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
        let headers: HTTPHeaders = [
         .authorization(username: "", password: "")]
      
        let soapMessage = HolidayServiceMessage(soapAction: "web:CapitalCity")
        soapMessage.countryCode = "US"
        let soapEnvelope = SOAPEnvelope(soapMessage: soapMessage)
        print(soapEnvelope.toXMLString() ?? "nil")
        
        let service = Service(
            name: "dataservice/transaction.getView",
            parameters: [
                Parameter(
                    name: "columnList",
                    value: "PERSON.FIRSTNAME,PERSON.PREFIX,PERSON.NAME,ACCESSKEY.RCN,READER.NAME"
                ),
                Parameter(
                    name: "filterTransTypeList",
                    value: "1,2"
                ),
                Parameter(
                    name: "fromDate",
                    value: "2021-01-17 00:00:00"
                ),
            ]
        )
        
        //print(service.toXMLString() ?? "nil")
        let service2 = Service2(country: Country(value: "US"))
        //print(service2.toXMLString() ?? "nil")
        let message2 = SOAPMessage(XMLString: service2.toXMLString() ?? "nil")
        let envelope3 = SOAPEnvelope(soapMessage: message2!)
        //print(envelope3.toXMLString() ?? "nil")
        
        AF.request("http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.soap(withAction: "http://webservices.oorsprong.org/websamples.countryinfo#web:CapitalCity", soapVersion: .version1point0)).responseString { response in
            switch response.result {
            case .success(let token):
             completion(.success(token))
            case .failure(let error):
             completion(.failure(error))
            }
        }
        
        }

    
    class Service: XMLMappable {
        var nodeName: String! = "SERVICE"
        
        var name: String?
        var parameters: [Parameter]?
        
        init(name: String?, parameters: [Parameter]?) {
            self.name = name
            self.parameters = parameters
        }
        
        required init?(map: XMLMap) {}
        
        func mapping(map: XMLMap) {
            name <- map.attributes["name"]
            parameters <- map["PARAMETERS.PARAMETER"]
        }
    }

    class Parameter: XMLMappable {
        var nodeName: String!
        
        var name: String?
        var value: String?
        
        init(name: String?, value: String?) {
            self.name = name
            self.value = value
        }
        
        required init?(map: XMLMap) {}
        
        func mapping(map: XMLMap) {
            name <- map.attributes["name"]
            value <- map.innerText
        }
    }
    
    class Service2: XMLMappable {
        var nodeName: String! = "web:CapitalCity"
        
        var country: Country?
        
        init(country: Country?) {
            self.country = country
        }
        
        required init?(map: XMLMap) {
            
        }
        
        func mapping(map: XMLMap) {
            country <- map["web:sCountryISOCode"]
        }
    }
    
    class Country: XMLMappable {
        
        var nodeName: String!
        var value: String?
        
        init(value: String?) {
            self.value = value
        }
        
        required init?(map: XMLMap) {
            
        }
        
        func mapping(map: XMLMap) {
            value <- map.innerText
        }
        
        
    }
    
    class HolidayServiceMessage: SOAPMessage {

        var countryCode: String?

        override func mapping(map: XMLMap) {
            super.mapping(map: map)

            countryCode <- map["web:sCountryISOCode"]
        }
    }
    
    
    
    
    }

