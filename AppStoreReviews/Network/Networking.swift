//
//  Networking.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
  case success(T)
  case failure(NetworkError)
}

enum NetworkError {
  case unknown
  case noJSONData
}


struct Networking {
    
    func performRequest<T: Decodable>(type: T.Type, endpoint: EndpointType, completion: @escaping (NetworkResponse<T>) -> ()) {

        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        URLSession.shared.dataTask(with: url){(data,  response, err) in

            guard err == nil else { return completion(.failure(.unknown)) }
            guard let response = response as? HTTPURLResponse else { return completion(.failure(.noJSONData)) }

            switch response.statusCode { // 3
            case 200...299:
                guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else {
                    return completion(.failure(.unknown))
                } // 4
                completion(.success(model))
            default:
                completion(.failure(.unknown))
            }
            
        }.resume()
    }
    
}
