//
//  FirstViewController.swift
//  TabControllerApp
//
//  Created by Eduard Moya on 6/7/18.
//  Copyright © 2018 Eduard Moya. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {
    lazy var lblViewName: UILabel = defaultTitleLabel("First view")
    lazy var lblViewPurpose: UILabel = defaultSubTitleLabel("This is the default viewController")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() {
        //add subviews
        view.addSubview(lblViewName)
        view.addSubview(lblViewPurpose)

        //set view title constraints
        lblViewName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblViewName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblViewName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        lblViewName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true

        //set view purpose constraints
        lblViewPurpose.topAnchor.constraint(equalTo: lblViewName.bottomAnchor, constant: 8.0).isActive = true
        lblViewPurpose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
        lblViewPurpose.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
    }
}
