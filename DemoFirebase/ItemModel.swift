//
//  ItemModel.swift
//  DemoFirebase
//
//  Created by jeisson on 11/25/18.
//  Copyright © 2018 jeisson. All rights reserved.
//

import Foundation
import Firebase

struct ItemModel {
    
    let text: String
    let ref: DatabaseReference?
    let key: String
    
    init(text: String, key: String="") {
        self.text = text
        self.ref = nil
        self.key = key
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let text = value["text"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.text = text
    }
}
