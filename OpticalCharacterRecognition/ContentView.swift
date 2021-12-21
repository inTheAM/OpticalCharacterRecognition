//
//  ContentView.swift
//  OpticalCharacterRecognition
//
//  Created by Ahmed Mgua on 21/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    /// The recognizer object.
    @StateObject var recognizer = TextRecognizer()
    
    /// The image to recognize
    let image = UIImage(named: "London")!
    
    var body: some View {
        ScrollView {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 450)
            Button("Recognize text") {
                recognizer.recognizeText(in: image)
            }
            .font(.subheadline.bold())
            .buttonStyle(.borderedProminent)
            if recognizer.isRecognizing {
                ProgressView()
            } else {
                Text(recognizer.recognizedText)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
