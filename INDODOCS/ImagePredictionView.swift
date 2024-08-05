//
//  ImagePredictionView.swift
//  INDODOCS
//
//  Created by Heical Chandra on 05/08/24.
//

import SwiftUI

struct ContentView2: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @StateObject private var classifier = ImageClassifier()

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Select Image")
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }

            Button(action: {
                if let image = selectedImage {
                    classifier.classifyImage(image: image)
                }
            }) {
                Text("Classify Image")
            }

            Text("Result: \(classifier.classificationResult)")
        }
        .padding()
    }
}
