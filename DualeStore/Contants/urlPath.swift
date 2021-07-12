//
//  urlPath.swift
//  DualeStore
//
//  Created by Duash on 7/12/21.
//

import Foundation

class UrlPath {
    static let path = UrlPath()
    static let sections = Bundle.main.decodeFile([Section].self, from: "dualeStories.json")
    private init () {}
    var api_url_path = "http://www.json-generator.com/api/json/get/bZSUjtwYAy?indent=2"
    func sharePathUrl()->String {
           return api_url_path
   }
}
