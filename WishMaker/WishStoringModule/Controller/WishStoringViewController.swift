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
        static let error: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Private fields
    private var color: UIColor?
    
    // MARK: - Lifecycle
    init(_ color: UIColor?) {
        super.init(nibName: nil, bundle: nil)
        self.color = color
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
    
    override func loadView() {
        super.loadView()
        view = WishStoringView(delegate: self, color: color)
    }
}

// MARK: - WishStoringViewDelegate
extension WishStoringViewController: WishStoringViewDelegate {
    func presentWarningAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func presentEditAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func presentActivityController(_ activityController: UIActivityViewController) {
        present(activityController, animated: true)
    }
    
    func closeScreen() {
        dismiss(animated: true)
    }
    
    func deleteWish(_ id: Int) {
        WishCoreDataService.shared.deleteElement(id)
    }
    
    func editWish(_ id: Int, newText: String) {
        WishCoreDataService.shared.editElement(id, newValue: newText)
    }
    
    func getWishes() -> [String] {
        WishCoreDataService.shared.getElements()
    }
    
    func getWish(_ id: Int) -> String {
        WishCoreDataService.shared.getElement(id)
    }
    
    func addWish(text: String) {
        WishCoreDataService.shared.addElement(text: text)
    }
}
