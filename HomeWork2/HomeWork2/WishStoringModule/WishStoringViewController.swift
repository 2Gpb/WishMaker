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
            static let heightForRow: CGFloat = 48
            static let addWishSectionsCount: Int = 1
            static let titleDelete: String = "Удалить"
            static let titleEdit: String = "Изменить"
        }
        
        enum Alert {
            static let title: String = "Error!"
            static let message: String = "Please enter a wish"
            static let actionTitle: String = "OK"
        }
        
        enum EditAlert {
            static let title: String = "Edit"
            static let message: String = "Please enter an edited wish"
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
    private let defaults: WishServiceLogic = WishDefaultsService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        WishCoreDataService.shared.logCoreDataDBPath()
        setUp()
        wishArray = defaults.getElements(for: .wishList)
    }
    
    // MARK: - Setup
    private func setUp() {
        view.backgroundColor = .systemCyan
        
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
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.Table.cornerRadius
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        table.pinTop(to: closeButton.bottomAnchor, Constants.Table.offset)
        table.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        table.pinHorizontal(to: view, Constants.Table.offset)
    }
    
    private func setUpWarningAlert() {
        let warningAlert: UIAlertController = UIAlertController(title: Constants.Alert.title,
                                                                message: Constants.Alert.message,
                                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.Alert.actionTitle, style: .cancel)
        warningAlert.addAction(alertAction)
        present(warningAlert, animated: true)
    }
    
    private func setUpEditAlert(index: Int) {
        let editAlert: UIAlertController = UIAlertController(title: Constants.EditAlert.title,
                                                             message: Constants.EditAlert.message,
                                                             preferredStyle: .alert)
        editAlert.addTextField()
        editAlert.textFields?.first?.text = wishArray[index]
        
        let alertAction = UIAlertAction(title: Constants.Table.titleEdit, style: .default) { [weak self] _ in
            let newValue = editAlert.textFields?.first?.text ?? ""
            self?.wishArray = self?.defaults.editElement(for: .wishList, index: index, newValue: newValue) ?? []
            self?.table.reloadData()
        }
        
        editAlert.addAction(alertAction)
        present(editAlert, animated: true)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.Table.titleDelete) { [weak self] (_, _, completion) in
            self?.wishArray = self?.defaults.deleteElement(for: .wishList, index: indexPath.row) ?? []
            tableView.reloadData()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: Constants.Table.titleEdit) { [weak self] (_, _, completion) in
            self?.setUpEditAlert(index: indexPath.row)
            completion(true)
        }
        
        editAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [editAction])
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
                    self?.wishArray = self?.defaults.addElement(for: .wishList, index: indexPath.row, newValue: text) ?? []
                    tableView.reloadData()
                } else {
                    self?.setUpWarningAlert()
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
