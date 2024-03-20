

import UIKit

final class CellTableView: UITableViewCell, NibLoadableView, ReusableView {
    
    var numbers: [Int] = []
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
}

private extension CellTableView {
    func setupCell() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 50, height: 50)
        layout.sectionInset.left = 16
        layout.minimumLineSpacing = 16
        
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.register(CellCollectionView.self)
    }
}

extension CellTableView {
    func updateNumbers() {
        let randomIndexPath = collectionView.indexPathsForVisibleItems.randomElement()
        if let indexPath = randomIndexPath {
            let randomIndex = indexPath.item
            numbers[randomIndex] = Int.random(in: 1...99)
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension CellTableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CellCollectionView = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setCell(number: numbers[indexPath.row])
        return cell 
    }
}
