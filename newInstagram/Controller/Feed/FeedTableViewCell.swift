import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoSubtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setBordersLayout(object: photoImage, width: 1, radius: 5, color: .systemBlue)
    }
    
    func setBordersLayout(object: AnyObject, width: CGFloat, radius: CGFloat, color: UIColor) {
        object.layer.borderWidth = width
        object.layer.cornerRadius = radius
        object.layer.borderColor = color.cgColor
    }
}
