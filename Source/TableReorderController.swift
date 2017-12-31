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

import Foundation
import UIKit

/**
 An instance of `TableReorderController` allows reordering of rows in a table view.
 */
public struct TableReorderController {

    // MARK: Typealiases

    /**
     Asks if a row at the specified index path is movable for the specified table view.

     - parameter tableView: The table view requesting this information.
     - parameter indexPath: The index path of the item.

     - returns: `true` if the specified row is movable, `false` otherwise.
     */
    public typealias CanMoveRowConfig = (_ tableView: UITableView, _ indexPath: IndexPath) -> Bool

    /**
     Commits the movement for the specified index path.

     - parameter tableView: The table view being edited.
     - parameter sourceIndexPath:    The source index path of the row being moved.
     - parameter destinationIndexPath: The destination index path of the row being moved.
     */
    public typealias MoveRowConfig = (_ tableView: UITableView, _ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) -> Void

    /// A closure that determines if a given row is movable.
    public let canMoveRow: CanMoveRowConfig

    /// A closure that commits the movement for a table view.
    public let moveRow: MoveRowConfig

    // MARK: Initialization

    /**
     Constructs a new `TableReorderController`.

     - parameter canMoveRow:    The closure that determines if a given row is movable.
     - parameter moveRow: The closure that commits the movement for a table view.

     - returns: A new `TableReorderController` instance.
     */
    public init(canMoveRow: @escaping CanMoveRowConfig, moveRow: @escaping MoveRowConfig) {
        self.canMoveRow = canMoveRow
        self.moveRow = moveRow
    }
}
