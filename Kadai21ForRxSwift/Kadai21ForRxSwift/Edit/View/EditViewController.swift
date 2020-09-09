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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarItem()
        self.viewModel = EditViewModel()
        
        
        viewModel?.isError
            .subscribe(onNext: { [unowned self] event in
                if !event {
                    self.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        inputTextField.rx.text.orEmpty.asDriver()
            .drive(onNext: { [unowned self] text in
                self.viewModel?.inputText = text
            })
            .disposed(by: disposeBag)
        
        inputTextField.rx.controlEvent(.editingDidEnd).asDriver()
            .drive(onNext: { [unowned self] _ in
                self.viewModel?.registrationData()
            }).disposed(by: disposeBag)
    }
    
    func setupNavigationBarItem() {
        self.leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close,
                                                        target: nil, action: nil)
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                                        target: nil, action: nil)
        
        leftBarButton?.rx.tap
            .subscribe { [unowned self] _ in           // 「_ in」が重要
                self.dismiss(animated: true) }
            .disposed(by: self.disposeBag)
        
        rightBarButton?.rx.tap
            .subscribe { [unowned self] _ in           // 「_ in」が重要
                self.viewModel?.registrationData()
            }
            .disposed(by: self.disposeBag)
        
        self.navigationItem.setLeftBarButton(self.leftBarButton, animated: true)
        self.navigationItem.setRightBarButton(self.rightBarButton, animated: true)
    }
}
