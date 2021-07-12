//
//  KidsFriendlyViewCell.swift
//  DualeStore
//
//  Created by Duash on 7/11/21.
//

import UIKit

class KidsFriendlyViewCell: UICollectionViewCell , selfConfiguringCollectionViewCell {
    static let cellReuseIdentifier: String = Localized.kidFriendlyIdentifier.localized
    let descrip = UILabel()
    let name = UILabel()
    let subheading = UILabel()
    let imageView = UIImageView()
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.populateForKidsCell()
        let imagestackview = UIStackView(arrangedSubviews: [imageView])
        imagestackview.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [imagestackview, subheading ,descrip , name])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: subheading)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(with story: Story) {
        descrip.text = story.descrip.uppercased()
        imageView.image = UIImage(named: story.image)
        name.text = story.name
        subheading.text = story.subheading
    }
}
