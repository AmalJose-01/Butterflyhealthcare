
import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.cellReuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to Dequeue Reusable Table View Cell with identifier \(T.cellReuseIdentifier) at \(indexPath)")
    }
    return cell
  }

  func dequeueReusableCell<T: UITableViewCell>(for identifier: String = T.cellReuseIdentifier) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.cellReuseIdentifier) as? T else {
      fatalError("Unable to Dequeue Reusable Table View Cell with identifier \(T.cellReuseIdentifier)")
    }
    return cell
  }

  final func register(cellTypes: [UITableViewCell.Type]) {
    cellTypes.forEach {
      self.register(cellType: $0)
    }
  }

  final func register<T: UITableViewCell>(cellType: T.Type) {
    let nibID = NibID(type: cellType)
    if let nib = nibID?.nib {
      self.register(nib, forCellReuseIdentifier: cellType.cellReuseIdentifier)
    } else {
      fatalError("Please add \(cellType.cellReuseIdentifier) as case for NibID")
    }
  }
}
