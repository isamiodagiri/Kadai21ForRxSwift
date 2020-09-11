//
//  MainViewController.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/07.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.setupTableView()
            self.setupViewModel()
        }
    }
    
    private var rightBarButton: UIBarButtonItem?
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = MainViewController.dataSource()
    
    private var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fetchItem()
    }
}
extension MainViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<SectionOfRegister> {
        return RxTableViewSectionedReloadDataSource(
            configureCell: { dataSource, tableView, indexPath, registerData in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        if let cell = cell as? RegisterTableViewCell {
        //            cell.setup(title: registerData.title)
        //        }
                cell.accessoryType = .detailButton
                cell.textLabel?.text = registerData.title
                cell.imageView?.image = #imageLiteral(resourceName: "checkMark")
                return cell
            },
            canEditRowAtIndexPath: { _, _ in
                return true
            }
        )
    }
    
    private func setupViewModel() {
        viewModel = MainViewModel()

        viewModel?.items
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func setupNavigationBarButton() {
        self.rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                                        target: nil, action: nil)
        
        self.rightBarButton?.rx.tap
            .subscribe { [weak self] _ in           // 「_ in」が重要
                self?.segue() }
            .disposed(by: self.disposeBag)
        
        self.navigationItem.setRightBarButton(self.rightBarButton, animated: true)
    }
    
    func segue(_ model: RegisterModel? = nil) {
        let vc = EditViewController.instance(model)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {

    private func setupTableView() {
        self.tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx
            .itemDeleted
            .subscribe(onNext: {
                self.viewModel?.removeItem(at: $0)})
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: {
                print($0)})
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemAccessoryButtonTapped
            .subscribe(onNext: { [unowned self] index in
                self.segue()})
            .disposed(by: disposeBag)
    }
}
