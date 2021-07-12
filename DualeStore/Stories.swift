//
//  App.swift
//  DualeStore
//
//  Created by Duash on 7/8/21.
//

import Foundation

struct Story: Decodable , Hashable  {
    let id: Int
    let descrip: String
    let name: String
    let subheading: String
    let image: String
}
