//
//  APIServices.swift
//  INDODOCS
//
//  Created by Heical Chandra on 25/07/24.
//

import Foundation

class APIService {
    func sendChatRequest(userPrompt: String, completion: @escaping (Result<ChatResponse, Error>) -> Void) {
        guard let url = URL(string: "https://major-gisella-caldev-4864ed86.koyeb.app/chat") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let chatRequest = ChatRequest(user_prompt: userPrompt)
        do {
            let jsonData = try JSONEncoder().encode(chatRequest)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
                completion(.success(chatResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
