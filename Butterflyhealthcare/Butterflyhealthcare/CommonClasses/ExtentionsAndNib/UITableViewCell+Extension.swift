
import Foundation
import UIKit

public extension UITableViewCell {
  static var cellReuseIdentifier: String {
    return String(describing: self)
  }
}
