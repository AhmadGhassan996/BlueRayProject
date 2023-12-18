//
//  RadiatorImageCell.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 15/12/2023.
//

import UIKit

final class RadiatorImageCell: UICollectionViewCell {
    @IBOutlet private weak var radiatorImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    func config(image: String?) {
        radiatorImage.kf.setImage(with: URL(string: image ?? "" ),placeholder: UIImage(named: "placeHolder"))
    }

}
