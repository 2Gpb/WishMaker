//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit
import Foundation

final class WishMakerViewController: UIViewController {
    // MARK: - Private fields
    private let wishStoringViewController: UIViewController = WishStoringViewController()
    private let wishCalendarViewController: UIViewController = WishCalendarViewController()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = WishMakerView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    // MARK: - SetUp
    private func setUpNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - WishMakerViewDelegate
extension WishMakerViewController: WishMakerViewDelegate {
    func presentWishStoringViewController() {
        present(wishStoringViewController, animated: true)
    }
    
    func pushWishCalendarViewController() {
        navigationController?.pushViewController(wishCalendarViewController, animated: true)
    }
    
    func presentColorPicker(_ picker: UIColorPickerViewController) {
        picker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        self.present(picker, animated: true)
    }
}
