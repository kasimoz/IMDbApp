//
//  NetworkManager.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 15.10.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Networkable {
    func fetchNowPlaying(completion: @escaping (HomeBaseResponse?, Error?) -> ())
    func fetchUpcoming(page: Int, completion: @escaping (HomeBaseResponse?, Error?) -> ())
    func fetchDetail(movieId: Int, completion: @escaping (DetailBaseResponse?, Error?) -> ())
}


class NetworkManager : Networkable  {
    func fetchNowPlaying(completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
        request(target : .now_playing, type: HomeBaseResponse.self, completion: completion)
    }
    
    func fetchUpcoming(page: Int, completion: @escaping (HomeBaseResponse?, Error?) -> ()) {
        request(target : .upcoming(page: page), type: HomeBaseResponse.self, completion: completion)
    }
    
    func fetchDetail(movieId: Int, completion: @escaping (DetailBaseResponse?, Error?) -> ()) {
        request(target : .movie(movieId: movieId), type: DetailBaseResponse.self, completion: completion)
    }
    
}

private extension NetworkManager {
    
    func request<T: Mappable>(target: API,
                              type: T.Type,
                              completion: @escaping (T?, Error?) -> Void) {
        
        Alamofire.request(target.baseURL.absoluteString.appending(target.path), method: target.method, parameters: target.task.parameters, encoding: target.task.encoding, headers: target.headers).validate(statusCode: 200..<401).responseObject { (response: DataResponse<T>) in
            
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
    
    func requestArray<T: Mappable>(target: API,
                                   type: T.Type,
                                   completion: @escaping ([T]?, Error?) -> Void) {
        
        Alamofire.request(target.baseURL.absoluteString.appending(target.path), method: target.method, parameters: target.task.parameters, encoding: target.task.encoding, headers: target.headers).validate(statusCode: 200..<401).responseArray { (response: DataResponse<[T]>) in
            
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

