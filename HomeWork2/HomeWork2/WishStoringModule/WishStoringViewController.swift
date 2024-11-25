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
            static let titlesSections: [String] = ["Add wish", "Wishes"]
            static let heightForRow: CGFloat = 44
            static let addWishSectionsCount: Int = 1
        }
        
        enum Alert {
            static let title: String = "Error!"
            static let message: String = "Please enter a wish"
            static let actionTitle: String = "OK"
        }
        
        enum Defaults {
            static let wishesKey: String = "Wishes"
        }
    }
    
    // MARK: - Private variables
    private var wishArray: [String] = []
    
    // MARK: - Private fields
    private let closeButton: UIButton = UIButton(type: .close)
    private let table: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        wishArray = defaults.array(forKey: Constants.Defaults.wishesKey) as? [String] ?? []
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
        
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = Constants.Table.cornerRadius
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        table.pinTop(to: closeButton.bottomAnchor)
        table.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        table.pinHorizontal(to: view, Constants.Table.offset)
    }
    
    private func setUpAlert() {
        let alert = UIAlertController(title: Constants.Alert.title, message: Constants.Alert.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.Alert.actionTitle, style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Table.heightForRow
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.Table.titlesSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Constants.Table.titlesSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.Table.addWishSectionsCount
        case 1:
            return wishArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            ) as? AddWishCell else {
                return UITableViewCell()
            }
            
            cell.addWish = { [weak self] text in
                if text != "" {
                    self?.wishArray.append(text)
                    self?.defaults.set(self?.wishArray, forKey: Constants.Defaults.wishesKey)
                    tableView.reloadData()
                } else {
                    self?.setUpAlert()
                }
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            ) as? WrittenWishCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: wishArray[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
