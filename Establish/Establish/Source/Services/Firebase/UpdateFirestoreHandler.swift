//
//  UpdateFirestoreHandler.swift
//  Establish
//
//  Created by Joshua Brown on 27/02/2022.
//

import Foundation
import Combine
import Firebase

final class UpdateFirestoreHandler {
    
    enum NetworkError: Error {
        case pathWasNil
        case firestorePostError(err: Error)
    }
    
    private let database: Firestore
    private let collectionPaths: [String: String]
    
    public static let shared = UpdateFirestoreHandler()
    
    init() {
        let firestoreSettings = FirestoreSettings()
        Firestore.firestore().settings = firestoreSettings
        
        self.database = Firestore.firestore()
        self.collectionPaths = [
            "events": "events"
        ]
    }
    
    public func createNewEvent(payload: EventPayload) -> Future<Void, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            if let path = self.collectionPaths["events"] {
                self.database.collection(path).document(payload.id.uuidString).setData([
                    "id": payload.id.uuidString,
                    "accessCode": payload.accessCode,
                    "name": payload.name,
                    "location": payload.location,
                    "date": payload.date,
                    "isRecurring": payload.isRecurring,
                    "recurringType": payload.recurringType ?? "",
                    "monzoLink": payload.monzoLink as Any,
                    "creator": payload.creator,
                    "tags": payload.tags,
                    "attendees": payload.attendees
                ]) { err in
                    if let err = err {
                        promise(.failure(NetworkError.firestorePostError(err: err)))
                    } else {
                        promise(.success(()))
                    }
                }
            } else {
                promise(.failure(NetworkError.pathWasNil))
            }
        }
    }
}
