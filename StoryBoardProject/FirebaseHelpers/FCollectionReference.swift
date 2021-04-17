//
//  FCollectionReference.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 13.03.2021.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
   case User
   case Recent
    }


func FireBaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}


