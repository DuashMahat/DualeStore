//
//  StoriesTableCell.swift
//  DualeStore
//
//  Created by Duash on 7/9/21.
//

import UIKit

class StoriesTableCell: UICollectionViewCell , selfConfiguringCollectionViewCell {
    static let cellReuseIdentifier: String = Localized.storiesFeaturedIdentifier.localized
    
    let name = UILabel()
    let subheading = UILabel()
    let imageView = UIImageView()
    let buyButton = UIButton(type: .custom)
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.populateForStoriesDualeCell()
        let labelsStackView = UIStackView(arrangedSubviews: [name , subheading])
        labelsStackView.axis = .vertical
        
        let contentsStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView , buyButton])
        contentsStackView.axis = .horizontal
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false 
        contentsStackView.alignment = .center
        contentsStackView.spacing = 15
        
        contentView.addSubview(contentsStackView)
        
        
        NSLayoutConstraint.activate([
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])

    }
    
    func configureCell(with story: Story) {
        name.text = story.name
        subheading.text = story.subheading
        imageView.image = UIImage(named: story.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
