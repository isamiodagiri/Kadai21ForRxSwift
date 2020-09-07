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
    let items = PublishSubject<[SectionOfRegister]>()

    func updateItem() {
        let dataList: [RegisterModel] = RealmManager.shared.fetchRegisterData() ?? []
        let section: [SectionOfRegister] = dataList
            .map { SectionOfRegister(items: [$0]) }
        
        items.onNext(section)
    }
    
    func testItem() {
        let section: [SectionOfRegister] = [SectionOfRegister(items: [RegisterModel(title: "testData1")]),
                                            SectionOfRegister(items: [RegisterModel(title: "testData2")]),
                                            SectionOfRegister(items: [RegisterModel(title: "testData3")])]
        
        items.onNext(section)
    }
}
