//
//  Item.swift
//  ItemsNew
//
//  Created by Pablo on 30/10/18.
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import UIKit

class Item {
    
    var nome = ""
    var destaque = ""
    
    var height: CGFloat = 100
    
    init(nome:String, destaque:String) {
        self.nome = nome
        self.destaque = destaque
    }
}
