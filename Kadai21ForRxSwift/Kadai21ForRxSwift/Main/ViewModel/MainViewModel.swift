//
//  MainViewModel.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/07.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct SectionOfRegister {
    var items: [RegisterModel]
}

extension SectionOfRegister: SectionModelType {
    
    typealias Item = RegisterModel

    init(original: SectionOfRegister, items: [SectionOfRegister.Item]) {
        self = original
        self.items = items
    }
}

class MainViewModel {
    let items = BehaviorSubject<[SectionOfRegister]>(value: [])
    let fetchModel = PublishSubject<RegisterModel>()
    
    func fetchItem() {
        let dataList: [RegisterModel] = RealmManager.shared.fetchRegisterData() ?? []
        let section: [SectionOfRegister] = [SectionOfRegister(items: dataList)]
        
        items.onNext(section)
    }
    
    func fecthEditModelData(at indexPath: IndexPath) {
        guard let list = try? items.value() else { return }
        
        let items = list[indexPath.section].items
        let model = items[indexPath.row]

        self.fetchModel.onNext(model)
    }
    
    func removeItem(at indexPath: IndexPath) {
        guard let list = try? items.value() else { return }
        
        var items = list[indexPath.section].items
        let model = items[indexPath.row]
        RealmManager.shared.deleteRegisterData(data: model)
        
        items.remove(at: indexPath.row)
        let section: [SectionOfRegister] = [SectionOfRegister(items: items)]

        self.items.onNext(section)
    }
}
