//
//  seeAllDualeStoriesCell.swift
//  DualeStore
//
//  Created by Duash on 7/9/21.
//

import UIKit

class seeAllDualeStoriesCell: UICollectionViewCell , selfConfiguringCollectionViewCell  {
    static let cellReuseIdentifier: String = Localized.seeAllDualeIdentifier.localized
     let name = UILabel()
     let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        name.font = UIFont.preferredFont(forTextStyle: .title1)
        name.textColor = .label
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        

        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        
        let mainStackView = UIStackView(arrangedSubviews: [imageView , name])
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false 
        
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        mainStackView.setCustomSpacing(20, after: imageView)
    }
    
    func configureCell(with story: Story) {
        name.text = story.name
        imageView.image = UIImage(named: story.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
