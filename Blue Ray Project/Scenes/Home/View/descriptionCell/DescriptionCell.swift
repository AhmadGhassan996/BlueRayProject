
import UIKit

final class DescriptionCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 8
        titleLabel.layer.masksToBounds = true
    }
    func config(title: String?, description: String?) {
        titleLabel.text = title
        descriptionLabel.attributedText = description?.htmlToAttributedString()
    }
}
