//
//  ItemsCollectionView.swift
//  ItemsNew
//
//  Created by Pablo on 30/10/18.
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import UIKit

class ItemsCollectionView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let items = [
        Item(nome: "Item A", destaque: "Destaque A Destaque A Destaque A Destaque A Destaque A"),
        Item(nome: "Item B", destaque: ""),
        
        Item(nome: "Item C", destaque: ""),
        Item(nome: "Item D", destaque: "Destaque D Destaque D Destaque D Destaque D Destaque D"),
        
        Item(nome: "Item E", destaque: ""),
        Item(nome: "Item F", destaque: ""),
        
        Item(nome: "Item G", destaque: "Destaque G"),
        Item(nome: "Item H", destaque: "Destaque H Destaque H")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    func load() {
        Bundle.main.loadNibNamed("\(ItemsCollectionView.self)", owner: self)
        addSubview(contentView)
        contentView.frame = bounds;
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(ItemView.self)")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ItemsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let i = indexPath.row
        
        var height = ItemView.calculateHeight(width: collectionView.bounds.width / 2, item: items[i])
        
        if i % 2 == 0 {
           height = max(height, ItemView.calculateHeight(width: collectionView.bounds.width / 2, item: items[i + 1]))
        } else {
           height = max(height, ItemView.calculateHeight(width: collectionView.bounds.width / 2, item: items[i - 1]))
        }
        
        return CGSize(width: collectionView.bounds.width / 2, height: height)
    }
}

extension ItemsCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemView.self)", for: indexPath)
        cell.bounds = collectionView.layoutAttributesForItem(at: indexPath)!.bounds
        
        let itemView = ItemView(frame: cell.bounds)
        itemView.configure(item: items[indexPath.row])
        cell.backgroundView = itemView
        
        return cell
    }
}
