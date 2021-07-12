//
//  Bundle-Decodable-Hashable.swift
//  DualeStore
//
//  Created by Duash on 7/8/21.
//

import Foundation
import UIKit

// Any extension to the the app Bundle/s go here
extension Bundle  {
    // using generic to use the type applicable at that time to minimize function calls
    func decodeFile <T: Decodable > ( _ fileType: T.Type , from file: String ) -> T {
        // get the url path
        guard let url = self.url(forResource: file , withExtension: nil ) else { fatalError("Unable to grab url from \(file)")}
        // get date from the content of url
        guard let data = try? Data(contentsOf: url) else { fatalError("Unable to grab data from \(url)")}
        // get decoder that decodes an instance of section that will be used in the collectionView
        let decoder = JSONDecoder()
        // the decoded data
        guard let storeData = try? decoder.decode(T.self, from: data) else { fatalError("Unable to storeData from \(decoder)")}
        return storeData
    }
}



class NetworkingApiCall {
    func decode <T: Decodable>  (from urlPath : String  , completion: @escaping (T.Type) -> ()) {
        guard let url = URL(string: urlPath) else {fatalError("Can not get url from \(urlPath)")}
            URLSession.shared.dataTask(with: url, completionHandler: { (data , response , error ) in
                guard let data = try? Data(contentsOf: url) else { fatalError("Unable to grab data from \(url)")}
                
                let decoder = JSONDecoder()
                
                guard let storeData = try? decoder.decode(T.self, from: data) else { fatalError("Unable to storeData from \(decoder)")}
                completion(storeData as! T.Type)
                }).resume()
     }
}











