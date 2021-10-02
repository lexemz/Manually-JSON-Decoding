//
//  NetworkManager.swift
//  HandleJSONDecode
//
//  Created by Igor on 02.10.2021.
//

import Foundation
enum ErrorType: Error {
    case badURL
    case emptyData
    case decodeError
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchData(from url: String, with completion: @escaping (Result<RandomUser, ErrorType>) -> Void) {
        guard let correctURL = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: correctURL) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error info")
                completion(.failure(.emptyData))
                return
            }
            
            guard let dataAny = try? JSONSerialization.jsonObject(with: data) else {
                completion(.failure(.decodeError))
                return
            }
            
            guard let dataDict = dataAny as? [String: Any] else { return }
            
            let userInfo = RandomUser(value: dataDict)
            completion(.success(userInfo))
        }.resume()
    }
}
