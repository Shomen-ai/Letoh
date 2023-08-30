// MARK: - ViewModel

import Foundation

protocol HotelViewModelProtocol: AnyObject {
    var updateView: (HotelData) -> Void { get set }
    func getData()
}

final class HotelViewModel: HotelViewModelProtocol {
    var updateView: (HotelData) -> Void = { _ in }
    func getData() {
        APIService().getData(apiKey: .hotel) { [weak self] result in
            switch result {
            case .success(let data):
                self?.updateView(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
