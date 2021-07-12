//
//  SectionHeaderCell.swift
//  DualeStore
//
//  Created by Duash on 7/10/21.
//

import UIKit

class SectionHeaderCell: UICollectionReusableView , selfConfiguringReusableCell{
    static let cellReuseIdentifier: String = Localized.sectionHeaderIdentifier.localized
    let title = UILabel()
    let subTitle = UILabel()
    let seeAllButton = UIButton(type: .custom)
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.populateForSectionHeader()
        let stackView = UIStackView(arrangedSubviews: [separator, title , subTitle])
        stackView.axis = .vertical
        let outerStackView = UIStackView(arrangedSubviews: [stackView , seeAllButton])
        outerStackView.translatesAutoresizingMaskIntoConstraints =  false
        outerStackView.axis = .horizontal
        addSubview(outerStackView)
       
        
        NSLayoutConstraint.activate([
           
            separator.heightAnchor.constraint(equalToConstant: 1 ),
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -10) // pull up
        ])
        
        outerStackView.setCustomSpacing(5, after: separator)
        outerStackView.spacing = 0
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
