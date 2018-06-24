//
//  MainViewController.swift
//  TabControllerApp
//
//  Created by Eduard Moya on 6/7/18.
//  Copyright © 2018 Eduard Moya. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    //Custom init -- To remove xibs/storyboards
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabItems()
    }

    func setupTabItems() -> Void {
        //create tab bar items/ViewControllers
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()

        //set tab items' name, icon and tag
        firstVC.tabBarItem = UITabBarItem(title: "First", image: #imageLiteral(resourceName: "first"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: #imageLiteral(resourceName: "second"), tag: 1)

        //set items to tab bar controller and select default tab
        viewControllers = [firstVC, secondVC]
        selectedViewController = viewControllers?.first
    }
}
