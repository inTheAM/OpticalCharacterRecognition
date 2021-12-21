//
//  TextRecognitionService.swift
//  OpticalCharacterRecognition
//
//  Created by Ahmed Mgua on 21/12/2021.
//

import UIKit.UIImage
import Vision

///#A protocol for services that offer text recognition functionality.
protocol TextRecognitionServiceProtocol {
    
    /// A type that represents a closure that takes a Result that
    /// contains either a String or a TextRecognitionError and returns nothing.
    typealias TextRecognitionHandler = (Result<String, TextRecognitionError>) -> Void
    
    /// Performs a text recognition request on an image.
    /// - Parameters:
    ///   - image: The image to scan for text.
    ///   - completion: A closure the method runs on the main thread when scanning is complete.
    ///                 The closure takes a result that contains either a String representing
    ///                 the recognized text or a recognition error.
    func recognizeText(in image: UIImage, _ completion: @escaping TextRecognitionHandler)
}

///#A service that performs text recognition on a UIImage.
struct TextRecognitionService: TextRecognitionServiceProtocol {
    
    func recognizeText(in image: UIImage, _ completion: @escaping TextRecognitionHandler) {
        /// Switching to the utility thread.
        DispatchQueue.global(qos: .utility).async {
            /// Obtaining the cgImage.
            guard let cgImage = image.cgImage else {
                completion(.failure(.failedToGetCGImage))
                return
            }
            
            /// Creating a request handler to perform recognition requests.
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            /// Creating a request to recognize the text in the image.
            let request = VNRecognizeTextRequest { request, error in
                
                /// If an error occurs during scanning, the method calls a failed completion closure and exits.
                guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                    completion(.failure(.failedToRecognizeText))
                    return
                }
                
                /// If recognition was successful, the scanned texts are joined
                /// using a new line character (`\n`), assigned to a string
                /// and returned in the completion closure.
                let text = observations.compactMap { observation in
                    let string = observation.topCandidates(1).first?.string
                    return string
                }.joined(separator: "\n")
                
                /// Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(text))
                    return
                }
            }
            
            /// Performing the request.
            try? requestHandler.perform([request])
        }
    }
}
