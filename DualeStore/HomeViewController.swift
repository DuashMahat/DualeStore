//
//  ViewController.swift
//  DualeStore
//
//  Created by Duash on 7/8/21.
//

import UIKit

class HomeViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section , Story>?
    let sections = UrlPath.sections
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = Localized.navtitle.localized
        self.registerCellsForHomeView()
        view.addSubview(collectionView)
        self.createDiffiableDataSource()
        self.reloadSnapShottedData()
    }
    

}

