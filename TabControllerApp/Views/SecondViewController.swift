//
//  SecondViewController.swift
//  TabControllerApp
//
//  Created by Eduard Moya on 6/7/18.
//  Copyright © 2018 Eduard Moya. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    lazy var lblViewName: UILabel = titleLabel("Second view", UIColor.brown)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() -> Void {
        view.addSubview(lblViewName)
        lblViewName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblViewName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblViewName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        lblViewName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
    }
}

