//
//  selfConfiguringCollectionViewCell.swift
//  DualeStore
//
//  Created by Duash on 7/12/21.
//

import Foundation


protocol selfConfiguringCollectionViewCell {
    static var cellReuseIdentifier: String {get}
    func configureCell(with story: Story)
}
