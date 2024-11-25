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
        enum Slider {
            static let max: Double = 1
            static let min: Double = 0
            
            static let red: String = "Red"
            static let green: String = "Green"
            static let blue: String = "Blue"
        }
        
        enum Stack {
            static let radius: CGFloat = 20
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
        }
        
        enum Title {
            static let text: String = "Wish Maker"
            static let fontSize: CGFloat = 32
            static let top: CGFloat = 20
        }
        
        enum Description {
            static let text: String = "This app will bring you joy and will fulfill three of your wishes!\n - The first wish is to change the background color."
            static let numberOfLines: Int = 4
            static let top: CGFloat = 20
            static let leading: CGFloat = 20
        }
        
        enum ColorButton {
            static let picker: String = "Pick color"
            static let hide: String = "Hide sliders"
            static let show: String = "Show sliders"
            static let random: String = "Rand color"
            static let height: CGFloat = 44
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 10
            static let indent: CGFloat = Stack.leading * 2 + leading * 2
        }
        
        enum Picker {
            static let title: String = "Background Color"
        }
        
        enum AddWishButton {
            static let title: String = "Add wish"
            static let cornerRadius: CGFloat = 20
            static let height: CGFloat = 44
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
            static let trailing: CGFloat = 20
        }
    }
    
    // MARK: - Private fields
    private let wishTitle: UILabel = UILabel()
    private let wishDescription: UILabel = UILabel()
    private let slidersStack: UIStackView = UIStackView()
    private let sliderRed: CustomSlider = CustomSlider(title: Constants.Slider.red, min: Constants.Slider.min, max: Constants.Slider.max)
    private let sliderGreen: CustomSlider = CustomSlider(title: Constants.Slider.green, min: Constants.Slider.min, max: Constants.Slider.max)
    private let sliderBlue: CustomSlider = CustomSlider(title: Constants.Slider.blue, min: Constants.Slider.min, max: Constants.Slider.max)
    private let colorPicker: UIColorPickerViewController = UIColorPickerViewController()
    private let colorPickerButton: CustomButton = CustomButton(title: Constants.ColorButton.picker)
    private let showHideButton: CustomButton = CustomButton(title: Constants.ColorButton.hide)
    private let randomColorButton: CustomButton = CustomButton(title: Constants.ColorButton.random)
    private let addWishButton: UIButton = UIButton(type: .system)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Setup
    private func setUp() {
        view.backgroundColor = .black
        
        setUpTitle()
        setUpDescription()
        setUpAddWishButton()
        setUpSliders()
        setUpColorPicker()
        setUpColorPickerButton()
        setUpShowHideButton()
        setUpRandomColorButton()
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
    
    private func setUpAddWishButton() {
        addWishButton.backgroundColor = .white
        addWishButton.setTitle(Constants.AddWishButton.title, for: .normal)
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.layer.cornerRadius = Constants.AddWishButton.cornerRadius
        addWishButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(addWishButton)
        addWishButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.AddWishButton.leading)
        addWishButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, Constants.AddWishButton.trailing)
        addWishButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.AddWishButton.bottom)
        addWishButton.setHeight(Constants.AddWishButton.height)
    }
    
    private func setUpSliders() {
        slidersStack.axis = .vertical
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.layer.cornerRadius = Constants.Stack.radius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            slidersStack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] in
                self?.changeBackgroundColor()
                slider.currentValue.text = "\(Int(CGFloat(slider.slider.value) * 100))%"
            }
        }
        
        view.addSubview(slidersStack)
        slidersStack.pinCenterX(to: view)
        slidersStack.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, Constants.Stack.leading)
        slidersStack.pinBottom(to: addWishButton.topAnchor, Constants.Stack.bottom)
    }
    
    private func setUpColorPicker() {
        colorPicker.title = Constants.Picker.title
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
    }
    
    private func setUpColorPickerButton() {
        colorPickerButton.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        
        view.addSubview(colorPickerButton)
        colorPickerButton.setWidth((view.frame.width - CGFloat(Constants.ColorButton.indent)) / CGFloat(3))
        colorPickerButton.setHeight(Constants.ColorButton.height)
        colorPickerButton.pinLeft(to: slidersStack)
        colorPickerButton.pinBottom(to: slidersStack.topAnchor, Constants.ColorButton.bottom)
    }
    
    private func setUpShowHideButton() {
        showHideButton.addTarget(self, action: #selector(showHideSliders), for: .touchUpInside)
        
        view.addSubview(showHideButton)
        showHideButton.setWidth((view.frame.width - CGFloat(Constants.ColorButton.indent)) / CGFloat(3))
        showHideButton.setHeight(Constants.ColorButton.height)
        showHideButton.pinLeft(to: colorPickerButton.trailingAnchor, Constants.ColorButton.leading)
        showHideButton.pinBottom(to: slidersStack.topAnchor, Constants.ColorButton.bottom)
    }
    
    private func setUpRandomColorButton() {
        randomColorButton.addTarget(self, action: #selector(changeBackgroundRandomColor), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.setWidth((view.frame.width - CGFloat(Constants.ColorButton.indent)) / CGFloat(3))
        randomColorButton.setHeight(Constants.ColorButton.height)
        randomColorButton.pinLeft(to: showHideButton.trailingAnchor, Constants.ColorButton.leading)
        randomColorButton.pinBottom(to: slidersStack.topAnchor, Constants.ColorButton.bottom)
    }
    
    // MARK: - Actions
    private func changeBackgroundColor() {
        let red = sliderRed.slider.value
        let green = sliderGreen.slider.value
        let blue = sliderBlue.slider.value
        
        view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
    @objc
    private func presentColorPicker() {
        self.present(colorPicker, animated: true)
    }
    
    @objc
    private func showHideSliders() {
        if slidersStack.isHidden {
            slidersStack.isHidden = false
            showHideButton.setTitle(Constants.ColorButton.hide, for: .normal)
        } else {
            slidersStack.isHidden = true
            showHideButton.setTitle(Constants.ColorButton.show, for: .normal)
        }
    }
    
    @objc
    private func changeBackgroundRandomColor() {
        view.backgroundColor = .random
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        view.backgroundColor = color
    }
}

