//
//  TextRecognizer.swift
//  OpticalCharacterRecognition
//
//  Created by Ahmed Mgua on 21/12/2021.
//

//import Foundation
import UIKit.UIImage

/// #The view model that handles text recognition in a view.
final class TextRecognizer: ObservableObject {
    /// The text recognition service.
    private let recognitionService: TextRecognitionServiceProtocol
    @Published var recognizedText = ""
    @Published var isRecognizing = false
    
    init(service: TextRecognitionServiceProtocol = TextRecognitionService()) {
        self.recognitionService = service
    }
    
    /// Uses the recognitionService to perform a text recognition request on the image.
    /// - Parameter image: The image to scan for text.
    func recognizeText(in image: UIImage) {
        isRecognizing = true
        recognitionService.recognizeText(in: image) { [weak self] result in
            switch result {
            case .success(let text):
                self?.recognizedText = text
                self?.isRecognizing = false
            case .failure(let error):
                print(error)
                self?.isRecognizing = false
            }
        }
    }
}
