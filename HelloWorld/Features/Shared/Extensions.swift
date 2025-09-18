import UIKit
extension UIViewController {
    func setSafeBackgroundColor() {
        if #available(iOS 13.0, *) { view.backgroundColor = .systemBackground }
        else { view.backgroundColor = .white }
    }
}
