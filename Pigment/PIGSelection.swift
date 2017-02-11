//
//  PIGSelection.swift
//  Pigment
//
//  Created by Brandon Schmuck on 2/10/17.
//  Copyright © 2017 Brandon Schmuck. All rights reserved.
//

import UIKit

class PIGSelection: NSObject {
    static let shared = PIGSelection()
    var selectedMode: PIGMode = .complimentary
    var currentColor = UIColor.white
}
