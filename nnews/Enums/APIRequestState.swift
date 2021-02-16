//
//  APIRequestState.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation
import Moya

enum APIRequestState {
    case notStarted
    case requesting
    case success
    case failed(err: Error)
    case finished
    
    /**
     Returns true if state is requesting.
     */
    var isRequesting: Bool {
        self == .requesting
    }
    
    /**
     Returns true if state is success.
     */
    var isSuccessful: Bool {
        self == .success
    }
    
    /**
     Returns true if state is failed.
     */
    var isFailed: Bool {
        switch self {
        case .failed: return true
        default: return false
        }
    }
    
    /**
     Return error for failed state only.
     */
    var error: Error? {
        switch self {
        case .failed(let err): return err
        default: return nil
        }
    }
    
    /**
     Returns true if state is finished.
     */
    var isFinished: Bool {
        self == .finished
    }
}

extension APIRequestState: Equatable {
    static func ==(lhs: APIRequestState, rhs: APIRequestState) -> Bool {
        switch (lhs, rhs) {
        case (.notStarted, .notStarted),
             (.requesting, .requesting),
             (.success, .success),
             (.finished, .finished):
            return true
        case (let .failed(lhsError), let .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
