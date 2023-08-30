// MARK: - MVVMBuilder
import Foundation
import UIKit

final class HotelViewBuilder {
    static func build() -> UIViewController {
        let viewController = HotelViewController()
        let viewModel = HotelViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
