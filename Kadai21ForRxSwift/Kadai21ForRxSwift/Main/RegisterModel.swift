//
//  RegisterModel.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/07.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import Foundation
import RealmSwift

class RegisterModel: Object {
    
    dynamic var id: String = NSUUID().uuidString
    dynamic var title: String?
    dynamic var timeStamp: Date = Date()

    init(title: String?) {
        self.title = title
    }
    
    required init() {}
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
