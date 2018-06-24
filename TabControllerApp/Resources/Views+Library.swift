//
//  Views+Library.swift
//  TabControllerApp
//
//  Created by Eduard Moya on 6/22/18.
//  Copyright © 2018 Eduard Moya. All rights reserved.
//

import UIKit

//MARK:- Labels templates
let titleLabel: (String, UIColor) -> UILabel = { (title, color) in
    let label = UILabel(frame: .zero)
    label.text = title
    label.font = UIFont.boldSystemFont(ofSize: UIDefaults.fontSize.title)
    label.textColor = color
    label.numberOfLines = 1
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

let subTitleLabel: (String, UIColor) -> UILabel = { (title, color) in
    let label = UILabel(frame: .zero)
    label.text = title
    label.font = UIFont.boldSystemFont(ofSize: UIDefaults.fontSize.subTitle)
    label.textColor = color
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

let defaultTitleLabel: (String) -> UILabel = { (title) in
    return titleLabel(title, UIDefaults.palette.title)
}

let defaultSubTitleLabel: (String) -> UILabel = { (title) in
    return subTitleLabel(title, UIDefaults.palette.subTitle)
}
