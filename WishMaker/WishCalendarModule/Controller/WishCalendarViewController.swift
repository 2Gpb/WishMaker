//
//  WishCalendarViewControlle.swift
//  HomeWork2
//
//  Created by Peter on 01.12.2024.
//
import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let error: String = "init(coder:) has not been implemented"
    }
    // MARK: - Private fields
    private var wishCalendarView: WishCalendarView?
    private var wishEventCreationController: WishEventCreationController?
    
    // MARK: - Lifecycle
    init(_ color: UIColor?) {
        super.init(nibName: nil, bundle: nil)
        wishCalendarView = WishCalendarView(delegate: self, color: color)
        wishEventCreationController = WishEventCreationController(delegate: self, color: color)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
    
    override func loadView() {
        super.loadView()
        view = wishCalendarView
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
        if let vc = wishEventCreationController {
            present(vc, animated: true)
        }
    }
    
    func goBackScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func getEvents() -> [CalendarEventModel] {
        EventCoreDataService.shared.getElements()
    }
    
    func getEvent(_ id: Int) -> CalendarEventModel {
        EventCoreDataService.shared.getElement(id)
    }
    
    func deleteEvent(id: Int) {
        EventCoreDataService.shared.deleteElement(id: id)
    }
}

// MARK: - WishEventCreationDelegate
extension WishCalendarViewController: WishEventCreationDelegate {
    func addEvent(_ event: CalendarEventModel) {
        EventCoreDataService.shared.addElement(eventModel: event)
        wishCalendarView?.reloadTable()
    }
}
