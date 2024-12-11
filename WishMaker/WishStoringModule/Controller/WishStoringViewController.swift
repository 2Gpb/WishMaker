//
//  WishStoringViewController.swift
//  HomeWork2
//
//  Created by Peter on 24.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = WishStoringView(delegate: self)
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
    
    func deleteWish(_ wish: Int16) -> [String] {
        WishCoreDataService.shared.deleteElement(wish)
        return WishCoreDataService.shared.getElements()
    }
    
    func editWish(_ wish: Int16, newText: String) -> [String] {
        WishCoreDataService.shared.editElement(wish, newValue: newText)
        return WishCoreDataService.shared.getElements()
    }
    
    func getWishes() -> [String] {
        WishCoreDataService.shared.getElements()
    }
    
    func addWish(_ wish: Int16, text: String) -> [String] {
        WishCoreDataService.shared.addElement(wish, text: text)
        return WishCoreDataService.shared.getElements()
    }
}
