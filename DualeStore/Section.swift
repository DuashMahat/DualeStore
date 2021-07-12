//
//  Section.swift
//  DualeStore
//
//  Created by Duash on 7/8/21.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let sectionIdentifer: String
    let title: String
    let subtitle: String
    let items: [Story]
}

