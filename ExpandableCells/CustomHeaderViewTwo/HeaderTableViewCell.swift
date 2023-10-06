
import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func rotateImage(_ expanded: Bool) {
        if expanded {
                UIView.animate(withDuration: 0.15) {
                self.chevron.transform = CGAffineTransform(rotationAngle: .pi / 2)
                }
        } else {
                UIView.animate(withDuration: 0.15) {
                self.chevron.transform = .identity
                }
        }
    }
}
