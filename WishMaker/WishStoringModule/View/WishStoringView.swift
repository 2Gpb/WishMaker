//
//  WishStoringView.swift
//  HomeWork2
//
//  Created by Peter on 03.12.2024.
//

import UIKit

protocol WishStoringViewDelegate: AnyObject {
    func presentWarningAlert(_ alert: UIAlertController)
    func presentEditAlert(_ alert: UIAlertController)
    func presentActivityController(_ activityController: UIActivityViewController)
    func closeScreen()
    
    func deleteWish(_ id: Int)
    func editWish(_ id: Int, newText: String)
    func getWishes() -> [String]
    func getWish(_ id: Int) -> String
    func addWish(text: String)
}

final class WishStoringView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let backgroundColor: UIColor = .background
        }
        
        enum ShareButton {
            static let image: UIImage = UIImage(systemName: "square.and.arrow.up") ?? UIImage()
            static let state: UIControl.State = .normal
            static let tintColor: UIColor = .white
            static let event: UIControl.Event = .touchUpInside
            static let height: CGFloat = 30
            static let width: CGFloat = 30
            static let top: CGFloat = 20
            static let left: CGFloat = 20
        }
        
        
        enum CloseButton {
            static let image: UIImage = UIImage(systemName: "xmark.circle") ?? UIImage()
            static let state: UIControl.State = .normal
            static let tintColor: UIColor = .white
            static let event: UIControl.Event = .touchUpInside
            static let height: CGFloat = 30
            static let width: CGFloat = 30
            static let top: CGFloat = 20
            static let right: CGFloat = 20
        }
        
        enum Table {
            static let backgroundColor: UIColor = .clear
            static let separator:  UITableViewCell.SeparatorStyle = .none
            static let cornerRadius: CGFloat = 20
            static let offset: CGFloat = 20
            static let titlesSections: [String] = ["Add wish", "Wishes"]
            static let heightForRow: CGFloat = 52
            static let addWishSectionsCount: Int = 1
            static let titleDelete: String = "Delete"
            static let deleteActionStyle: UIContextualAction.Style = .destructive
            static let editActionStyle: UIContextualAction.Style = .destructive
            static let titleEdit: String = "Edit"
            static let headerTextColor: UIColor = .white
        }
        
        enum WarningAlert {
            static let title: String = "Error!"
            static let message: String = "Please enter a wish"
            static let preferredStyle: UIAlertController.Style = .alert
            static let actionStyle: UIAlertAction.Style = .cancel
            static let actionTitle: String = "OK"
        }
        
        enum EditAlert {
            static let title: String = "Edit"
            static let message: String = "Please enter an edited wish"
            static let preferredStyle: UIAlertController.Style = .alert
            static let actionTitle: String = "OK"
            static let actionStyle: UIAlertAction.Style = .default
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishStoringViewDelegate?
    
    // MARK: - Private variables
//    private var wishArray: [String] = []
    
    // MARK: - Private fields
    private let shareButton: UIButton = UIButton(type: .system)
    private let closeButton: UIButton = UIButton(type: .system)
    private let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycle
    init(delegate: WishStoringViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.View.backgroundColor
        
        setUpShareButton()
        setUpCloseButton()
        setUpTable()
    }
    
    private func setUpShareButton() {
        shareButton.setImage(Constants.ShareButton.image, for: Constants.ShareButton.state)
        shareButton.tintColor = Constants.ShareButton.tintColor
        shareButton.addTarget(self, action: #selector (shareButtonTapped), for: Constants.ShareButton.event)
        
        addSubview(shareButton)
        shareButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.ShareButton.top)
        shareButton.pinLeft(to: safeAreaLayoutGuide.leadingAnchor, Constants.ShareButton.left)
        shareButton.setHeight(Constants.ShareButton.height)
        shareButton.setWidth(Constants.ShareButton.width)
    }
    
    private func setUpCloseButton() {
        closeButton.setImage(Constants.CloseButton.image, for: Constants.CloseButton.state)
        closeButton.tintColor = Constants.CloseButton.tintColor
        closeButton.addTarget(self, action: #selector (closeButtonTapped), for: Constants.CloseButton.event)
        
        addSubview(closeButton)
        closeButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.CloseButton.top)
        closeButton.pinRight(to: safeAreaLayoutGuide.trailingAnchor, Constants.CloseButton.right)
        closeButton.setHeight(Constants.CloseButton.height)
        closeButton.setWidth(Constants.CloseButton.width)
    }
    
    private func setUpTable() {
        addSubview(table)
        
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = Constants.Table.backgroundColor
        table.separatorStyle = Constants.Table.separator
        table.layer.cornerRadius = Constants.Table.cornerRadius
        table.showsVerticalScrollIndicator = false
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        table.pinTop(to: closeButton.bottomAnchor, Constants.Table.offset)
        table.pinBottom(to: safeAreaLayoutGuide.bottomAnchor)
        table.pinHorizontal(to: self, Constants.Table.offset)
    }
    
    private func setUpWarningAlert() {
        let warningAlert: UIAlertController = UIAlertController(
            title: Constants.WarningAlert.title,
            message: Constants.WarningAlert.message,
            preferredStyle: Constants.WarningAlert.preferredStyle
        )
        
        let alertAction = UIAlertAction(
            title: Constants.WarningAlert.actionTitle,
            style: Constants.WarningAlert.actionStyle
        )
        
        warningAlert.addAction(alertAction)
        delegate?.presentWarningAlert(warningAlert)
    }
    
    private func setUpEditAlert(index: Int) {
        let editAlert: UIAlertController = UIAlertController(
            title: Constants.EditAlert.title,
            message: Constants.EditAlert.message,
            preferredStyle: Constants.EditAlert.preferredStyle
        )
        
        editAlert.addTextField()
        editAlert.textFields?.first?.text = delegate?.getWishes()[index]
        
        let alertAction = UIAlertAction(
            title: Constants.EditAlert.actionTitle,
            style: Constants.EditAlert.actionStyle
        ) { [weak self] _ in
            let newValue = editAlert.textFields?.first?.text ?? ""
            if newValue != "" {
                self?.delegate?.editWish(index, newText: newValue)
                self?.table.reloadData()
            } else {
                self?.delegate?.deleteWish(index)
                self?.table.reloadData()
            }
        }
        
        editAlert.addAction(alertAction)
        delegate?.presentEditAlert(editAlert)
    }
    
    // MARK: - Actions
    @objc
    private func shareButtonTapped() {
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: delegate?.getWishes() ?? [],
            applicationActivities: nil
        )
        
        delegate?.presentActivityController(activityViewController)
    }
    
    @objc
    private func closeButtonTapped() {
        delegate?.closeScreen()
    }
}

// MARK: - UITableViewDelegate
extension WishStoringView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = Constants.Table.headerTextColor
            header.automaticallyUpdatesBackgroundConfiguration = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Table.heightForRow
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: Constants.Table.deleteActionStyle,
            title: Constants.Table.titleDelete
        ) { [weak self] (_, _, completion) in
            self?.delegate?.deleteWish(indexPath.row)
            tableView.reloadData()
            completion(true)
        }
        
        switch indexPath.section {
        case 1:
            return UISwipeActionsConfiguration(actions: [deleteAction])
        default:
            return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(
            style: Constants.Table.editActionStyle,
            title: Constants.Table.titleEdit
        ) { [weak self] (_, _, completion) in
            self?.setUpEditAlert(index: indexPath.row)
            completion(true)
        }
        
        editAction.backgroundColor = .orange
        switch indexPath.section {
        case 1:
            return UISwipeActionsConfiguration(actions: [editAction])
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDataSource
extension WishStoringView: UITableViewDataSource {
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
            return delegate?.getWishes().count ?? 0
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
                    self?.delegate?.addWish(text: text)
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
            
            let wish = delegate?.getWish(indexPath.row)
            cell.configure(with: wish ?? "")
            return cell
        default:
            return UITableViewCell()
        }
    }
}
