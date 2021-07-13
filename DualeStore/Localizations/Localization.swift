//
//  Localization.swift
//  DualeStore
//
//  Created by Duash on 7/10/21.
//

import Foundation

public enum Localized: String {
    
    
    case dualeFeaturedIdentifier = "DualeFeatureCell"
    case storiesFeaturedIdentifier = "StoriesTableCell"
    case seeAllDualeIdentifier = "seeAllDualeStoriesCell"
    case sectionHeaderIdentifier = "SectionHeaderCell"
    case seeAllButtonTitle = "See All"
    case navtitle = "DualeStores"
    case kidFriendlyIdentifier = "KidsFriendlyViewCell"
    case accesibiltyTest = "Currently Live In"
    
    
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
