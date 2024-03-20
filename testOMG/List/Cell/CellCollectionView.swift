

import UIKit

final class CellCollectionView: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var numberTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = .identity
        }
    }
}

private extension CellCollectionView {
    func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .purple
        contentView.layer.cornerRadius = 12
        
        numberTextLabel.textColor = .white
        numberTextLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
}

extension CellCollectionView {
    func setCell(number: Int) {
        numberTextLabel.text = "\(number)"
    }
}
