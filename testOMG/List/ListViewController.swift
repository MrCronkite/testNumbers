

import UIKit

final class ListViewController: UIViewController {
    
    private var timer: Timer?
    private var arrayOfArrays: [[Int]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNumbers()
        configureAppearance()
        setupTimer()
    }
}

private extension ListViewController {
    func configureAppearance() {
        view.backgroundColor = .gray
        
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellTableView.self)
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateCells),
            userInfo: nil,
            repeats: true
        )
    }
    
    func generateNumbers() {
        arrayOfArrays = (0...140).reduce(into: []) { result, _ in
            let randomArray = (10...30).map { _ in Int.random(in: 1...99) }
            result.append(randomArray)
        }
    }
    
    @objc
    func updateCells() {
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else { return }
        for indexPath in visibleIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? CellTableView {
                cell.updateNumbers()
            }
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellTableView = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.numbers = arrayOfArrays[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

