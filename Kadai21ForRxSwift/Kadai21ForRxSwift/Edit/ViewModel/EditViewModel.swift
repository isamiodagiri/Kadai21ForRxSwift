//
//  EditViewModel.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/09.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class EditViewModel {
    
    var model: RegisterModel?
    var inputText: String?
    
    var isError = PublishRelay<Bool>()
    
    init(model: RegisterModel? = nil) {
        self.model = model
    }
    
    func registrationData() {
        guard let inputText = self.inputText, !inputText.isEmpty else {
            self.isError.accept(true)
            return
        }
        
        if let model = self.model {
            RealmManager.shared.updateRegisterModel(title: inputText, model)
        }
        else {
            RealmManager.shared.pushRegisterData(text: inputText)
        }
        self.isError.accept(false)
    }
}
