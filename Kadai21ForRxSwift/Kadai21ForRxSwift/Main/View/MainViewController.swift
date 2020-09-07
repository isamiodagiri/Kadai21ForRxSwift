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
    
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfRegister>(configureCell: configureCell)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfRegister>.ConfigureCell = { [weak self] dataSource, tableView, indexPath, registerData in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = registerData.title
        return cell
    }
    
    private var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension MainViewController {
    
    private func setupViewModel() {
        viewModel = MainViewModel()

        viewModel?.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel?.testItem()
    }
}

extension MainViewController: UITableViewDelegate {

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}
