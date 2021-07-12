//
//  viewsAndControllerExtenstions.swift
//  DualeStore
//
//  Created by Duash on 7/10/21.
//

import Foundation
import UIKit

extension DualeFeatureCell  {
    func populateViewForDualeFCell ()  {
        descrip.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        descrip.textColor = .systemBlue
        subheading.font = UIFont.preferredFont(forTextStyle: .title2)
        subheading.textColor = .secondaryLabel
        subheading.numberOfLines = 0
        name.textColor = .label
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        separator.translatesAutoresizingMaskIntoConstraints =  false
        separator.backgroundColor = .quaternaryLabel
    }
}


extension SectionHeaderCell {
    
    func populateForSectionHeader () {
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 30, weight: .bold))
        title.textColor = .label
        title.numberOfLines = 0
        
        subTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subTitle.textColor = .secondaryLabel
        subTitle.numberOfLines = 0
        
        seeAllButton.setTitle(Localized.seeAllButtonTitle.localized, for: .normal)
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
    }
}

extension StoriesTableCell  {
    func populateForStoriesDualeCell () {
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        name.numberOfLines = 0

        subheading.font = UIFont.preferredFont(forTextStyle: .title2)
        subheading.textColor = .secondaryLabel
        subheading.numberOfLines = 0

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
    
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)

        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel

    }
}


extension KidsFriendlyViewCell {
    func populateForKidsCell () {
        descrip.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        descrip.textColor = .systemBlue
        

        subheading.font = UIFont.preferredFont(forTextStyle: .title2)
        subheading.textColor = .secondaryLabel
        subheading.numberOfLines = 0
        

        name.textColor = .label
        name.font = UIFont.preferredFont(forTextStyle: .title2)

        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)

        separator.translatesAutoresizingMaskIntoConstraints = false 
        separator.backgroundColor = .quaternaryLabel

    }
}

extension HomeViewController {
    
    
    func registerCellsForHomeView () {
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCell.cellReuseIdentifier)
        self.collectionView.register(DualeFeatureCell.self, forCellWithReuseIdentifier: DualeFeatureCell.cellReuseIdentifier)
        self.collectionView.register(StoriesTableCell.self, forCellWithReuseIdentifier: StoriesTableCell.cellReuseIdentifier)
        self.collectionView.register(seeAllDualeStoriesCell.self, forCellWithReuseIdentifier: seeAllDualeStoriesCell.cellReuseIdentifier)
        self.collectionView.register(KidsFriendlyViewCell.self, forCellWithReuseIdentifier: KidsFriendlyViewCell.cellReuseIdentifier)
    }
    
    
    func createDiffiableDataSource () {
        dataSource = UICollectionViewDiffableDataSource<Section , Story> (collectionView: collectionView ) { collectionView , indexPath , story in
            switch self.sections[indexPath.section].sectionIdentifer {
            case "storiesSection":
                return self.configure(StoriesTableCell.self, with: story, for: indexPath)
            case "topCategories":
                return self.configure(seeAllDualeStoriesCell.self, with: story, for: indexPath)
            case "kidsFriendly":
                return self.configure(KidsFriendlyViewCell.self, with: story, for: indexPath)
            default:
                return self.configure(DualeFeatureCell.self, with: story, for: indexPath)
            }
    
        }
        
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderCell.cellReuseIdentifier, for: indexPath) as? SectionHeaderCell else {
                return nil
            }
            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty { return nil }
            sectionHeader.title.text = section.title
            sectionHeader.subTitle.text = section.subtitle
            return sectionHeader
        }
    }
    
    func configure < T: selfConfiguringCollectionViewCell > ( _ cellType: T.Type  , with story: Story  , for indexPath:  IndexPath ) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.cellReuseIdentifier, for: indexPath) as? T else {
            fatalError("Can not deque cell")
        }
        cell.configureCell(with: story)
        return cell
    }
    
    func reloadSnapShottedData () {
        var snapShot = NSDiffableDataSourceSnapshot<Section , Story> ()
        snapShot.appendSections(sections)
        for section in sections {
            snapShot.appendItems(section.items , toSection: section)
        }
        dataSource?.apply(snapShot)
    }
    
    
    func createCompositionFlowLayout () -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            switch section.sectionIdentifer {
            case "storiesSection":
                return self.createStoriesDualeLayoutSection(using: section)
            case "topCategories":
                return self.createSeeAllDualeLayoutSection(using: section)
            case "kidsFriendly":
                return self.KidsLayoutSection(using: section)
            default:
                return self.createDualeFeaturedLayoutSection(using: section)
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    
    
    func createDualeFeaturedLayoutSection (using section: Section) -> NSCollectionLayoutSection {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
        
    }

    
    
    func createStoriesDualeLayoutSection (using section: Section ) -> NSCollectionLayoutSection  {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        layoutSection.boundarySupplementaryItems = [createMyDualeSectionHeaderLayout()]
        return layoutSection
    }
    
    
    
    func createSeeAllDualeLayoutSection (using section: Section) -> NSCollectionLayoutSection {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.boundarySupplementaryItems = [createMyDualeSectionHeaderLayout()]
        return layoutSection
    }
    
    
    func KidsLayoutSection (using section: Section ) -> NSCollectionLayoutSection  {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    
    func createMyDualeSectionHeaderLayout () -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutItemSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.80), heightDimension: .estimated(85))
        let layoutHeaderSuppplem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutItemSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutHeaderSuppplem
    }
    
}
