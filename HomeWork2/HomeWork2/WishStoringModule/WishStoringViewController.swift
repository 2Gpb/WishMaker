//
//  WishStoringViewController.swift
//  HomeWork2
//
//  Created by Peter on 24.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum CloseButton {
            static let height: CGFloat = 40
            static let width: CGFloat = 40
            static let top: CGFloat = 20
            static let right: CGFloat = 20
        }
        
        enum Table {
            static let cornerRadius: CGFloat = 20
            static let offset: CGFloat = 20
        }
    }
    
    // MARK: - Private variables
    private var wishArray: [String] = ["I wish to add cell to the table"]
    
    // MARK: - Private fields
    private let closeButton: UIButton = UIButton(type: .close)
    private let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    private func setUp() {
        view.backgroundColor = .white
        
        setUpCloseButton()
        setUpTable()
    }
    
    private func setUpCloseButton() {
        closeButton.addTarget(self, action: #selector (closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.CloseButton.top)
        closeButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Constants.CloseButton.right)
        closeButton.setHeight(Constants.CloseButton.height)
        closeButton.setWidth(Constants.CloseButton.width)
    }
    
    private func setUpTable() {
        view.addSubview(table)
        
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.Table.cornerRadius
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        table.pin(to: view, Constants.Table.offset)
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath)
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
}
