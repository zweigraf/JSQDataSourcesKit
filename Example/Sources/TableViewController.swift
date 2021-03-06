//
//  Created by Jesse Squires
//  https://www.jessesquires.com
//
//
//  Documentation
//  https://jessesquires.github.io/JSQDataSourcesKit
//
//
//  GitHub
//  https://github.com/jessesquires/JSQDataSourcesKit
//
//
//  License
//  Copyright © 2015 Jesse Squires
//  Released under an MIT license: https://opensource.org/licenses/MIT
//

import UIKit

import JSQDataSourcesKit


final class TableViewController: UITableViewController {

    typealias TableCellFactory = ViewFactory<CellViewModel, UITableViewCell>
    var dataSourceProvider: DataSourceProvider<DataSource<Section<CellViewModel>>, TableCellFactory, TableCellFactory>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. create view models
        let section0 = Section(items: CellViewModel(), CellViewModel(), CellViewModel(), headerTitle: "First")
        let section1 = Section(items: CellViewModel(), CellViewModel(), CellViewModel(), CellViewModel(), headerTitle: "Second", footerTitle: "Only 2nd has a footer")
        let section2 = Section(items: CellViewModel(), CellViewModel(), headerTitle: "Third")
        let dataSource = DataSource(sections: section0, section1, section2)

        // 2. create cell factory
        let factory = ViewFactory(reuseIdentifier: CellId) { (cell, model: CellViewModel?, type, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model!.text
            cell.detailTextLabel?.text = "\(indexPath.section), \(indexPath.row)"
            cell.accessibilityIdentifier = "\(indexPath.section), \(indexPath.row)"
            return cell
        }

        // 3. create data source provider
        dataSourceProvider = DataSourceProvider(dataSource: dataSource, cellFactory: factory, supplementaryFactory: factory)

        // 4. set data source
        tableView.dataSource = dataSourceProvider?.tableViewDataSource


        // ** optional editing **
        // if needed, enable the editing functionality on the tableView
        let tableDataSourceEditingController = TableEditingController(
            canEditRow: { (tableView, indexPath) -> Bool in
                return true
        },
            commitEditing:{ [unowned self] (tableView, editingStyle, indexPath) in
                if editingStyle == .delete {
                    if let _ = self.dataSourceProvider?.dataSource.remove(at: indexPath) {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
        })

        dataSourceProvider?.tableEditingController = tableDataSourceEditingController
    }
}
