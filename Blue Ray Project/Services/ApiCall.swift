//
//  ApiCall.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 16/12/2023.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    func request<T: Codable>(urlString: String, method: HTTPMethod, parameters: [String: Any] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        if method == .post {
            request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.noData)) }
                return
            }

            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(responseObject)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        task.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
