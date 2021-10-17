//
//  API.swift
//  IMDBApp
//
//  Created by KasimOzdemir on 16.10.2021.
//

import Foundation
import Alamofire

enum API {
    case now_playing
    case upcoming(page: Int)
    case movie(movieId: Int)
}


extension API {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .now_playing:
            return "movie/now_playing"
        case .upcoming:
            return "movie/upcoming"
        case .movie(let movieId):
            return "movie/\(movieId)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .now_playing, .movie:
            return Task(parameters: ["api_key": Constants.IMDBApp.apiKey])
        case .upcoming(let page):
            return Task(parameters: ["page": page ,"api_key": Constants.IMDBApp.apiKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

struct Task {
    var parameters: Parameters? = nil
    var encoding: URLEncoding = URLEncoding.default
}


