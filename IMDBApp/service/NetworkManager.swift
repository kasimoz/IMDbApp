//
//  DataServiceApi.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Networkable {

    func fetchNowPlaying(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ())
    func fetchUpcoming(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ())
    func fetchDetail(movieId: Int, parameters: Parameters?, completion: @escaping (DetailBaseResponse?, Error?) -> ())
}


class NetworkManager : Networkable  {
    func fetchNowPlaying(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
        request(endPoint: Constants.EndPoint.now_playing, parameters: parameters, type: HomeBaseResponse.self, completion: completion)
    }
    
    func fetchUpcoming(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
        request(endPoint: Constants.EndPoint.upcoming, parameters: parameters, type: HomeBaseResponse.self, completion: completion)
    }
    
    func fetchDetail(movieId: Int, parameters: Parameters?, completion: @escaping (DetailBaseResponse?, Error?) -> ()) {
        request(endPoint: String(format:Constants.EndPoint.movie,movieId), parameters: parameters,type: DetailBaseResponse.self, completion: completion)
    }
    
}

private extension NetworkManager {

    func request<T: Mappable>(endPoint : String = "",
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: URLEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              type: T.Type,
                              completion: @escaping (T?, Error?) -> Void) {
   
        Alamofire.request(Constants.WebService.BaseUrl.appending(endPoint.isEmpty ? "" : endPoint), method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<401).responseObject { (response: DataResponse<T>) in

            if let error = response.error {
                completion(nil, error)
                return
            }
            if let value = response.result.value {
                completion(value, nil)
                return
            }
        }
    }
    
    func requestArray<T: Mappable>(endPoint : String = "",
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              type: T.Type,
                              completion: @escaping ([T]?, Error?) -> Void) {
   
        Alamofire.request(Constants.WebService.BaseUrl.appending(endPoint.isEmpty ? "" : endPoint), method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<401).responseArray { (response: DataResponse<[T]>) in

            if let error = response.error {
                completion(nil, error)
                return
            }
            if let value = response.result.value {
                completion(value, nil)
                return
            }
        }
    }
    
}


/*
 func requestNowPlaying(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
     DataService.shared.request(endPoint: Constants.EndPoint.now_playing, method: .get, parameters: parameters,type: HomeBaseResponse.self) { (response, error) in
         completion(response, error)
     }
 }
 
 func requestUpcoming(parameters: Parameters?, completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
     DataService.shared.request(endPoint: Constants.EndPoint.upcoming, method: .get, parameters: parameters,type: HomeBaseResponse.self) { (response, error) in
         completion(response, error)
     }
 }
 
 func requestDetail(movieId: Int, parameters: Parameters?, completion: @escaping (DetailBaseResponse?, Error?) -> ()) {
     DataService.shared.request(endPoint: String(format:Constants.EndPoint.movie,movieId), method: .get, parameters: parameters,type: DetailBaseResponse.self) { (response, error) in
         completion(response, error)
     }
 }
 */
