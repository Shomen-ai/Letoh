//
//  ViewController.swift
//  Letoh
//
//  Created by Дмитрий Шайманов on 30.08.2023.
//

import UIKit

final class HotelViewController: UIViewController {
    
    var viewModel: (HotelViewModelProtocol)?
    
    // MARK: - Properties
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(label)
        setupConstraints()
        viewModel?.getData()
        listenViewModel()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 10),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -10),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: 10),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -10)
        ])
    }
    
    func listenViewModel() {
        guard var viewModel = viewModel else { return }
        viewModel.updateView = { [weak self] hotelData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.label.text = "\(hotelData)"
            }
        }
    }
}
