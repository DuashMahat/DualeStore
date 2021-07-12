//
//  selfConfiguringCell.swift
//  DualeStore
//
//  Created by Duash on 7/8/21.
//

import Foundation

// this is a protocal with static variable and a function that will be conformed to any cell applicable
protocol selfConfiguringReusableCell {
    static var cellReuseIdentifier: String {get}
}

