
import UIKit

protocol HeaderViewDelegate: AnyObject {
    func expandedSection(button: UIButton)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: HeaderViewDelegate?

    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerButton: UIButton!
    
    func configure(title: String, section: Int) {
            lable.text = title
            headerButton.tag = section
        }
        
        func rotateImage(_ expanded: Bool) {
            if expanded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    UIView.animate(withDuration: 0.15) {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    UIView.animate(withDuration: 0.15) {
                    self.imageView.transform = .identity
                    }
                }
            }
        }
    
    @IBAction func tapHeader(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
}
