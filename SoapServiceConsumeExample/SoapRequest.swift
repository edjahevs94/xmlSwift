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
        //"<?xml version=\"\(version)\" encoding=\"\(encoding)\" standalone=\"\(standalone)\"?>"
        let soapMessage = SOAPMessage(soapAction: "web:sCountryISOCode", nameSpace: "web:sCountryISOCode")
        let content = SOAPMessage(XMLString: "<web:CapitalCity><web:sCountryISOCode>US</web:sCountryISOCode></web:CapitalCity>")
        let body = SOAPBody(XMLString: content?.toXMLString() ?? "nil")
        let envelope = SOAPEnvelope(XMLString: body?.toXMLString() ?? "nil")
        let soapEnvelope = SOAPEnvelope(soapMessage: soapMessage, soapVersion: .version1point2)
        let xml = soapEnvelope.toXMLString()
        let xml2 = body?.toXMLString()
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
        print(service2.toXMLString() ?? "nil")
        let message2 = SOAPMessage(XMLString: service2.toXMLString() ?? "nil")
        let envelope3 = SOAPEnvelope(soapMessage: message2!)
        print(envelope3.toXMLString() ?? "nil")
        
        AF.request("http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso", method: .post, parameters: service2.toXML(), encoding: XMLEncoding.default).responseString { response in
            switch response.result {
            case .success(let token):
             completion(.success(token))
            case .failure(let error):
             completion(.failure(error))
            }
        }
        
        }
    static func getHoliday(parameters:[String:Any] = [:], completion: @escaping (Swift.Result<String, Error>) -> ()) {
        let soapMessage = HolidayServiceMessage(soapAction: "GetHolidaysAvaible", nameSpace: "http://holidaywebservice.com/HolidayService_v2")
        soapMessage.countryCode = "UnitedStates"
        let soapEnvelope = SOAPEnvelope(soapMessage: soapMessage)
        print(soapEnvelope.toXMLString() ?? "nil")
        
        
        AF.request("http://holidaywebservice.com/HolidayService_v2/HolidayService2.asmx?wsdl", method: .post, parameters: soapEnvelope.toXML(), encoding: XMLEncoding.soap(withAction: "http://holidaywebservice.com/HolidayService_v2#GetHolidaysAvaible")).responseString { response in
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

            countryCode <- map["web:countrycode"]
        }
    }
    
    
    }

