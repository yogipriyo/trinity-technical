//
//  ContactCollectionViewCell.swift
//  Trinity Technical
//
//  Created by Yogi Priyo Prayogo on 15/04/23.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    private func setupViews() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        containerView.layer.cornerRadius = 8
        contactImage.layer.cornerRadius = contactImage.bounds.width/2
        contactImage.tintColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0/255.0, alpha: 1.0)
    }

}
