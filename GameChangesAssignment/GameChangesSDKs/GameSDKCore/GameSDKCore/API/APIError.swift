//
//  APIError.swift
//  GameSDKCore
//
//  Created by Abhayam Rastogi on 13/08/19.
//  Copyright © 2019 Abhayam. All rights reserved.
//

import Foundation

public enum APIError: Error {
    
    /// The underlying reason the `.parameterEncodingFailed` error occurred.
    public enum ParameterEncodingFailureReason {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        case jsonEncodingFailed(error: Error)
    }
    
    /// The underlying reason the `.parameterEncoderFailed` error occurred.
    public enum ParameterEncoderFailureReason {
        /// Possible missing components.
        public enum RequiredComponent {
            /// The `URL` was missing or unable to be extracted from the passed `URLRequest` or during encoding.
            case url
            /// The `HTTPMethod` could not be extracted from the passed `URLRequest`.
            case httpMethod(rawValue: String)
        }
        /// A `RequiredComponent` was missing during encoding.
        case missingRequiredComponent(RequiredComponent)
        /// The underlying encoder failed with the associated error.
        case encoderFailed(error: Error)
    }
    
    case error(Error)
    case noInternetConnection
    case noData
    case malformedRequest
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    /// `ParameterEncoder` threw an error while running the encoder.
    case parameterEncoderFailed(reason: ParameterEncoderFailureReason)
    
    var description: String{
        switch self {
        case .error(let error):
            return error.localizedDescription
        default:
            return Mirror(reflecting: self).children.first?.label ?? "unknown"
        }
    }
    
}
