//
//  TextRecognitionError.swift
//  OpticalCharacterRecognition
//
//  Created by Ahmed Mgua on 21/12/2021.
//

import Foundation

/// #An error that can occur during a text recognition request.
enum TextRecognitionError: Error {
    
    /// A failure to get a CGImage from a UIImage.
    case failedToGetCGImage
    
    /// A failure in performing the recognition request.
    case failedToRecognizeText
}
