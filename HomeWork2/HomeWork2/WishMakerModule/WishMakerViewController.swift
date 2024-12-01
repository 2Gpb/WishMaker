//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit
import Foundation

final class WishMakerViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        enum Title {
            static let text: String = "Wish Maker"
            static let fontSize: CGFloat = 32
            static let top: CGFloat = 10
        }
        
        enum Description {
            static let text: String = "This app will bring you joy and will fulfill three of your wishes!\n - The first wish is to change the background color."
            static let numberOfLines: Int = 4
            static let top: CGFloat = 10
            static let leading: CGFloat = 20
        }
        
        enum MoveActionsStack {
            static let addWishesTitle: String = "Add wish"
            static let scheduleWishesTitle: String = "Schedule wish granting"
            static let spacing: CGFloat = 20
            static let leading: CGFloat = 20
            static let bottom: CGFloat = 20
        }
        
        enum Slider {
            static let red: String = "Red"
            static let green: String = "Green"
            static let blue: String = "Blue"
            static let max: Double = 1
            static let min: Double = 0
        }
        
        enum SlidersStack {
            static let radius: CGFloat = 20
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
        }
        
        enum Picker {
            static let title: String = "Background Color"
        }
        
        enum ChangeColorButtonsStack {
            static let pickerTitle: String = "Pick color"
            static let hideTitle: String = "Hide sliders"
            static let showTitle: String = "Show sliders"
            static let randomTitle: String = "Rand color"
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
        }
    }
    
    // MARK: - Properties
    private var color: UIColor = .black {
        didSet {
            view.backgroundColor = color
            let buttons = [addWishesButton, scheduleWishesButton, colorPickerButton, showHideButton, randomColorButton]
            for i in buttons.indices {
                buttons[i].button.setTitleColor(color, for: .normal)
            }
        }
    }
    
    // MARK: - Private fields
    private let wishTitle: UILabel = UILabel()
    private let wishDescription: UILabel = UILabel()
    
    private let addWishesButton: CustomButton = CustomButton(title: Constants.MoveActionsStack.addWishesTitle)
    private let scheduleWishesButton: CustomButton = CustomButton(title: Constants.MoveActionsStack.scheduleWishesTitle)
    private let moveActionsStack: UIStackView = UIStackView()
    
    private let sliderRed: CustomSlider = CustomSlider(title: Constants.Slider.red, min: Constants.Slider.min, max: Constants.Slider.max)
    private let sliderGreen: CustomSlider = CustomSlider(title: Constants.Slider.green, min: Constants.Slider.min, max: Constants.Slider.max)
    private let sliderBlue: CustomSlider = CustomSlider(title: Constants.Slider.blue, min: Constants.Slider.min, max: Constants.Slider.max)
    private let slidersStack: UIStackView = UIStackView()
    
    private let colorPicker: UIColorPickerViewController = UIColorPickerViewController()
    
    private let colorPickerButton: CustomButton = CustomButton(title: Constants.ChangeColorButtonsStack.pickerTitle)
    private let showHideButton: CustomButton = CustomButton(title: Constants.ChangeColorButtonsStack.hideTitle)
    private let randomColorButton: CustomButton = CustomButton(title: Constants.ChangeColorButtonsStack.randomTitle)
    private let changeColorButtonsStack: UIStackView = UIStackView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .systemCyan
        
        setUpTitle()
        setUpDescription()
        setUpMoveActionsStack()
        setUpSlidersStack()
        setUpChangeColorButtonsStack()
    }
    
    private func setUpTitle() {
        wishTitle.text = Constants.Title.text
        wishTitle.font = .systemFont(ofSize: Constants.Title.fontSize, weight: .bold)
        wishTitle.textColor = .white
        wishTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wishTitle)
        wishTitle.pinCenterX(to: view)
        wishTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.Title.top)
    }
    
    private func setUpDescription() {
        wishDescription.text = Constants.Description.text
        wishDescription.textColor = .white
        wishDescription.numberOfLines = Constants.Description.numberOfLines
        wishDescription.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wishDescription)
        wishDescription.pinCenterX(to: view)
        wishDescription.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Description.leading)
        wishDescription.pinTop(to: wishTitle.bottomAnchor, Constants.Description.top)
    }
    
    private func setUpColorPicker() {
        colorPicker.title = Constants.Picker.title
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
    }
    
    private func setUpMoveActionsStack() {
        moveActionsStack.axis = .vertical
        moveActionsStack.spacing = Constants.MoveActionsStack.spacing
        
        let buttons = [addWishesButton, scheduleWishesButton]
        let actions = [addWishButtonPressed, scheduleWishesButtonPressed]
        
        for i in 0..<buttons.count {
            buttons[i].action = actions[i]
            moveActionsStack.addArrangedSubview(buttons[i])
        }
        
        view.addSubview(moveActionsStack)
        moveActionsStack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.MoveActionsStack.bottom)
        moveActionsStack.pinHorizontal(to: view, Constants.MoveActionsStack.leading)
    }
    
    private func setUpSlidersStack() {
        slidersStack.axis = .vertical
        slidersStack.layer.cornerRadius = Constants.SlidersStack.radius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            slidersStack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] in
                self?.slidersChangeBackgroundColor()
                slider.currentValue.text = "\(Int(CGFloat(slider.slider.value) * 100))%"
            }
        }
        
        view.addSubview(slidersStack)
        slidersStack.pinCenterX(to: view)
        slidersStack.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.SlidersStack.leading)
        slidersStack.pinBottom(to: moveActionsStack.topAnchor, Constants.SlidersStack.bottom)
    }
    
    private func setUpChangeColorButtonsStack() {
        changeColorButtonsStack.axis = .horizontal
        changeColorButtonsStack.spacing = 10
        changeColorButtonsStack.distribution = .fillEqually
        
        let buttons = [colorPickerButton, showHideButton, randomColorButton]
        let actions = [presentColorPicker, showHideSliders, randomChangeBackgroundColor]
        
        for i in 0..<buttons.count {
            buttons[i].action = actions[i]
            changeColorButtonsStack.addArrangedSubview(buttons[i])
        }
        
        view.addSubview(changeColorButtonsStack)
        changeColorButtonsStack.pinCenterX(to: view)
        changeColorButtonsStack.pinLeft(to: view, Constants.ChangeColorButtonsStack.leading)
        changeColorButtonsStack.pinBottom(to: slidersStack.topAnchor, Constants.ChangeColorButtonsStack.bottom)
    }
    
    // MARK: - Actions
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    private func scheduleWishesButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    private func slidersChangeBackgroundColor() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        
        self.color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    private func presentColorPicker() {
        setUpColorPicker()
        self.present(colorPicker, animated: true)
    }
    
    private func showHideSliders() {
        if slidersStack.isHidden {
            slidersStack.isHidden = false
            showHideButton.button.setTitle(Constants.ChangeColorButtonsStack.hideTitle, for: .normal)
        } else {
            slidersStack.isHidden = true
            showHideButton.button.setTitle(Constants.ChangeColorButtonsStack.showTitle, for: .normal)
        }
    }
    
    private func randomChangeBackgroundColor() {
        self.color = .random
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.color = color
    }
}

