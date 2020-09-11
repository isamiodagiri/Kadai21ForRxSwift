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
    var inputedText: String?
    
    var registeredText = PublishRelay<String>()
    var isError = PublishRelay<Bool>()
    
    init(_ model: RegisterModel?) {
        self.model = model
    }
    
    func checkText() {
        if let title = self.model?.title {
            self.registeredText.accept(title)
        }
    }
    
    func registrationData() {
        guard let inputedText = self.inputedText, !inputedText.isEmpty else {
            self.isError.accept(true)
            return
        }
        
        if let model = self.model {
            RealmManager.shared.updateRegisterModel(title: inputedText, model)
        }
        else {
            RealmManager.shared.pushRegisterData(text: inputedText)
        }
        self.isError.accept(false)
    }
}
