//
//  EditView.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/09.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    private var leftBarButton: UIBarButtonItem?
    private var rightBarButton: UIBarButtonItem?
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: EditViewModel?
    
    private var model: RegisterModel?
    
    static func instance(_ model: RegisterModel?) -> EditViewController {
        let vc = EditViewController()
        vc.model = model
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupNavigationBarItem()
        self.setupTextField()
        self.viewModel?.checkText()
    }
    
    func setupViewModel() {
        self.viewModel = EditViewModel(self.model)
        
        self.viewModel?.registeredText
            .subscribe(onNext: { [unowned self] text in
                self.inputTextField.text = text})
            .disposed(by: disposeBag)
        
        self.viewModel?.isError
            .subscribe(onNext: { [unowned self] isError in
                if !isError {
                    self.dismiss(animated: true)
                }})
            .disposed(by: disposeBag)
    }
    
    func setupNavigationBarItem() {
        self.leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close,
                                                        target: nil, action: nil)
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                                        target: nil, action: nil)
        
        self.leftBarButton?.rx.tap
            .subscribe { [unowned self] _ in
                self.dismiss(animated: true)}
            .disposed(by: self.disposeBag)
        
        self.rightBarButton?.rx.tap
            .subscribe { [unowned self] _ in
                self.viewModel?.registrationData()}
            .disposed(by: self.disposeBag)
        
        self.navigationItem.setLeftBarButton(self.leftBarButton, animated: true)
        self.navigationItem.setRightBarButton(self.rightBarButton, animated: true)
    }
    
    func setupTextField() {
        self.inputTextField.rx.text.orEmpty.asDriver()
            .drive(onNext: { [unowned self] text in
                self.viewModel?.inputedText = text})
            .disposed(by: disposeBag)
           
        self.inputTextField.rx.controlEvent(.editingDidEnd).asDriver()
            .drive(onNext: { [unowned self] _ in
                self.viewModel?.registrationData()})
            .disposed(by: disposeBag)
    }
}
