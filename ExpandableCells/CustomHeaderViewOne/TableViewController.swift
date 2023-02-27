
import UIKit

struct ExpandedModel {
    var isExpanded: Bool
    let title: String
    let array: [String]
}

class TableViewController: UITableViewController {
    
    let headerID = String(describing: CustomHeaderView.self)
    var arrayOfData = [ExpandedModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfData = [
            ExpandedModel(isExpanded: true, title: "Words", array: ["One", "Two", "Three", "Four", "Five"]),
            ExpandedModel(isExpanded: true, title: "Numbers", array: ["6", "7", "8", "9", "10"])
        ]
        tableViewConfig()
    }
    
    private func tableViewConfig() {
        let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        arrayOfData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !arrayOfData[section].isExpanded {
            return 0
        } else {
            return arrayOfData[section].array.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
        cell.label.text = arrayOfData[indexPath.section].array[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! CustomHeaderView
        
        header.configure(title: arrayOfData[section].title, section: section)
        header.rotateImage(arrayOfData[section].isExpanded)
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "anotherVC", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.estimatedSectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.estimatedSectionFooterHeight
    }
}

extension TableViewController: HeaderViewDelegate {
    func expandedSection(button: UIButton) {
        let section = button.tag
        let indexPaths = (0..<(arrayOfData[section].array.count)).map { IndexPath(row: $0, section: section)}
        
        arrayOfData[section].isExpanded.toggle()
        
        tableView.beginUpdates()
        
        if let header = tableView.headerView(forSection: section) as? CustomHeaderView {
                    header.rotateImage(arrayOfData[section].isExpanded)
        }
        
        if !arrayOfData[section].isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        tableView.endUpdates()
    }
}

