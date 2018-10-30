//
//  ItemView.swift
//  ItemsNew
//
//  Created by Pablo on 30/10/18.
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import UIKit

class ItemView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelDestaque: UILabel!
    
    @IBOutlet weak var layoutContraintLabelNomeHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    func load() {
        Bundle.main.loadNibNamed("\(ItemView.self)", owner: self)
        addSubview(contentView)
        contentView.frame = bounds;
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func configure(item: Item) {
        
        labelNome.text = item.nome
        labelDestaque.text = item.destaque
        labelDestaque.isHidden = item.destaque == ""
        
        if labelDestaque.isHidden {
            NSLayoutConstraint.activate([layoutContraintLabelNomeHeight])
        } else {
            NSLayoutConstraint.deactivate([layoutContraintLabelNomeHeight])
        }
    }
    
    static func calculateHeight(width: CGFloat, item: Item) -> CGFloat {
        
        var height = width / 2
        
        height = height + calculateHeight(text: item.nome, maxTextWidth: width - 16) + 16
        
        if item.destaque != "" {
            height = height + calculateHeight(text: item.destaque, maxTextWidth: width - 16) + 8
        }
        
        return height
    }
    
    static func calculateHeight(text: String?, maxTextWidth:CGFloat) -> CGFloat {
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let maxSize = CGSize(width: maxTextWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let labelRect = ((text ?? "") as NSString).boundingRect(
            with: maxSize,
            options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading],
            attributes: titleAttributes,
            context: nil)
        
        return labelRect.size.height
    }
}
