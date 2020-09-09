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
    
    @IBOutlet weak var editTextField: UITextField!
    
    private var leftBarButton: UIBarButtonItem?
    private var rightBarButton: UIBarButtonItem?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarItem()
    }
    
    func setupNavigationBarItem() {
        self.leftBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close,
                                                        target: nil, action: nil)
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                                        target: nil, action: nil)
        
        self.leftBarButton?.rx.tap
            .subscribe { [weak self] _ in           // 「_ in」が重要
                self?.dismiss(animated: true) }
            .disposed(by: self.disposeBag)
        
        self.rightBarButton?.rx.tap
            .subscribe { [weak self] _ in           // 「_ in」が重要
                print("asd") }
            .disposed(by: self.disposeBag)
        
        self.navigationItem.setLeftBarButton(self.leftBarButton, animated: true)
        self.navigationItem.setRightBarButton(self.rightBarButton, animated: true)
    }
}
