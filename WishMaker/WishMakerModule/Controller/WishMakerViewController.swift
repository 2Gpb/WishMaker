//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit
import Foundation

final class WishMakerViewController: UIViewController {
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
        let view = self.view as? WishMakerView
        let wishStoringViewController: UIViewController = WishStoringViewController(view?.getColor())
        present(wishStoringViewController, animated: true)
    }
    
    func pushWishCalendarViewController() {
        let view = self.view as? WishMakerView
        let wishCalendarViewController: UIViewController = WishCalendarViewController(view?.getColor())
        navigationController?.pushViewController(wishCalendarViewController, animated: true)
    }
    
    func presentColorPicker(_ picker: UIColorPickerViewController) {
        picker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        self.present(picker, animated: true)
    }
}
