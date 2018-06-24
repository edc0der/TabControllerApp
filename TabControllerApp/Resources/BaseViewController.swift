//
//  BaseViewController.swift
//  TabControllerApp
//
//  Created by Eduard Moya on 6/22/18.
//  Copyright © 2018 Eduard Moya. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //Custom init -- To remove xibs/storyboards
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() -> Void {
        view.backgroundColor = UIDefaults.palette.vcBackground
        configureView()
    }

    internal func configureView() -> Void {}
}
