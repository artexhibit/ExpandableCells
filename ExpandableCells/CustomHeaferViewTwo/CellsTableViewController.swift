
import UIKit

class CellsTableViewController: UITableViewController {

    var arrayOfData = [ExpandedModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfData = [
            ExpandedModel(isExpanded: false, title: "Words", array: ["One", "Two", "Three", "Four", "Five"]),
            ExpandedModel(isExpanded: false, title: "Numbers", array: ["6", "7", "8", "9", "10"]),
            ExpandedModel(isExpanded: false, title: "", array: [""])
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        arrayOfData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !arrayOfData[section].isExpanded || section == 2 {
            return 1
        } else {
            return arrayOfData[section].array.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section != 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
            cell.label.text = arrayOfData[indexPath.section].title
            cell.rotateImage(arrayOfData[indexPath.section].isExpanded)
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            cell.label.text = "Своя"
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentTableViewCell
            cell.label.text = arrayOfData[indexPath.section].array[indexPath.row - 1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2.5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2.5
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section != 2 {
            let indexPaths = (0..<(arrayOfData[indexPath.section].array.count)).map { IndexPath(row: $0 + 1, section: indexPath.section)}
            guard let cell = tableView.cellForRow(at: indexPath) as? HeaderTableViewCell else { return }
            
            arrayOfData[indexPath.section].isExpanded.toggle()
  
            tableView.beginUpdates()
            if !arrayOfData[indexPath.section].isExpanded {
                tableView.deleteRows(at: indexPaths, with: .fade)
            } else {
                tableView.insertRows(at: indexPaths, with: .fade)
            }
            cell.rotateImage(arrayOfData[indexPath.section].isExpanded)
            tableView.endUpdates()
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let cell = tableView.cellForRow(at: indexPath) as? ContentTableViewCell else { return }
            
            if cell.accessoryType != .checkmark {
                for section in 0..<tableView.numberOfSections {
                    for row in 1..<tableView.numberOfRows(inSection: section) {
                        guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) else { return }
                        cell.accessoryType = .none
                    }
                }
                cell.accessoryType = .checkmark
            }
        }
    }
}
