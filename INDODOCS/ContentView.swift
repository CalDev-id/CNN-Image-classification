//
//  ContentView.swift
//  INDODOCS
//
//  Created by Heical Chandra on 25/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var userPrompt: String = ""
    @State private var response: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    
    let apiService = APIService()
    
    var body: some View {
        VStack {
            TextField("Enter your prompt", text: $userPrompt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: sendChatRequest) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(isLoading)
            
            if isLoading {
                ProgressView()
                    .padding()
            }
            
            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
            
            Text("Response: \(response)")
                .padding()
        }
        .padding()
    }
    
    func sendChatRequest() {
        isLoading = true
        errorMessage = nil
        apiService.sendChatRequest(userPrompt: userPrompt) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let chatResponse):
                    response = chatResponse.response
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
