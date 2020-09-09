//
//  RegisterTableViewCell.swift
//  Kadai21ForRxSwift
//
//  Created by Isami Odagiri on 2020/09/08.
//  Copyright © 2020 Isami Odagiri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RegisterTableViewCell {
    func setup(title: String?) {
        self.titleLabel.text = title
    }
}
