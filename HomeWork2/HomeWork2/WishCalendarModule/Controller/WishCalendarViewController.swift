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
        view = WishCalendarView()
    }
}
