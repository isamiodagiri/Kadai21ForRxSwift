//
//  RealmManager.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/07.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    func fetchRegisterData() -> [RegisterModel]? {
        return self.fetch(RegisterModel.self)?
            .compactMap { $0 as? RegisterModel }
    }
    
    func pushRegisterData(text: String) {
        let model = RegisterModel()
        model.title = text
        
        self.push(model)
    }
    
    func deleteRegisterData(data: Object) {
        self.delete(data)
    }
    
    func updateRegisterModel(title: String, _ data: RegisterModel) {
        do {
            let realm = try Realm()
            try realm.write {
                data.title = title
                data.timeStamp = Date()
            }
        }
        catch {}
    }

    private func fetch(_ type: Object.Type) -> Results<Object>? {
        do {
            let realm = try Realm()
            return realm.objects(type)
        }
        catch {}
        
        return nil
    }
    
    private func push(_ data: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        }
        catch let error {
            print(error)
        }
    }
    
    private func delete(_ data: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(data)
            }
        }
        catch {}
    }
}
