//
//  WishCalendarViewControlle.swift
//  HomeWork2
//
//  Created by Peter on 01.12.2024.
//
import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let vc = WishCalendarView()
        vc.delegate = self
        view = vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    // MARK: - Private methods
    private func setUpNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - WishCalendarViewDelegate
extension WishCalendarViewController: WishCalendarViewDelegate {
    func createEvent() {
        navigationController?.pushViewController(WishEventCreationController(), animated: true)
    }
    
    func goBackScreen() {
        navigationController?.popViewController(animated: true)
    }
}
