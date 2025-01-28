//
//  WishMarkerView.swift
//  HomeWork2
//
//  Created by Peter on 02.12.2024.
//

import UIKit
import Foundation

protocol WishMakerViewDelegate: AnyObject {
    func presentWishStoringViewController()
    func pushWishCalendarViewController()
    func presentColorPicker(_ picker: UIColorPickerViewController)
}

final class WishMakerView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let backgroundColor: UIColor = .background
            static let state: UIControl.State = .normal
        }
        
        enum Title {
            static let text: String = "Wish Maker"
            static let fontSize: CGFloat = 32
            static let fontWeight: UIFont.Weight = .bold
            static let textColor: UIColor = .white
            static let top: CGFloat = 10
        }
        
        enum Description {
            static let text: String = "This app will bring you joy and will fulfill three of your wishes!\n - The first wish is to change the background color."
            static let numberOfLines: Int = 4
            static let textColor: UIColor = .white
            static let top: CGFloat = 10
            static let leading: CGFloat = 20
        }
        
        enum MoveActions {
            static let addWishesTitle: String = "Add wish"
            static let scheduleWishesTitle: String = "Schedule wish granting"
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let spacing: CGFloat = 18
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
        
        enum Sliders {
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let radius: CGFloat = 20
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
        }
        
        enum Picker {
            static let title: String = "Background Color"
            static let style: UIModalPresentationStyle = .popover
            static let interfaceStyle: UIUserInterfaceStyle = .dark
        }
        
        enum ChangeColorButtons {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let distribution: UIStackView.Distribution = .fillEqually
            static let pickerTitle: String = "Pick color"
            static let hideTitle: String = "Hide sliders"
            static let showTitle: String = "Show sliders"
            static let randomTitle: String = "Rand color"
            static let spacing: CGFloat = 10
            static let bottom: CGFloat = 20
            static let leading: CGFloat = 20
            static let alpha: CGFloat = 1
            static let state: UIControl.State = .normal
        }
    }
    
    //MARK: - Variables
    weak var delegate: WishMakerViewDelegate?
    
    // MARK: - Private properties
    private var color: UIColor = Constants.View.backgroundColor {
        didSet {
            self.backgroundColor = color
            let buttons = [addWishesButton,
                           scheduleWishesButton,
                           colorPickerButton,
                           showHideButton,
                           randomColorButton]
            for i in buttons.indices {
                buttons[i].setTitleColor(color)
            }
        }
    }
    
    // MARK: - Private fields
    private let wishTitle: UILabel = UILabel()
    private let wishDescription: UILabel = UILabel()
    private let addWishesButton: CustomButton = CustomButton(
        title: Constants.MoveActions.addWishesTitle
    )
    private let scheduleWishesButton: CustomButton = CustomButton(
        title: Constants.MoveActions.scheduleWishesTitle
    )
    private let moveActionsStack: UIStackView = UIStackView()
    private let sliderRed: CustomSlider = CustomSlider(
        title: Constants.Slider.red,
        min: Constants.Slider.min,
        max: Constants.Slider.max
    )
    private let sliderGreen: CustomSlider = CustomSlider(
        title: Constants.Slider.green,
        min: Constants.Slider.min,
        max: Constants.Slider.max
    )
    private let sliderBlue: CustomSlider = CustomSlider(
        title: Constants.Slider.blue,
        min: Constants.Slider.min,
        max: Constants.Slider.max
    )
    private let slidersStack: UIStackView = UIStackView()
    private let colorPicker: UIColorPickerViewController = UIColorPickerViewController()
    private let colorPickerButton: CustomButton = CustomButton(
        title: Constants.ChangeColorButtons.pickerTitle
    )
    private let showHideButton: CustomButton = CustomButton(
        title: Constants.ChangeColorButtons.hideTitle
    )
    private let randomColorButton: CustomButton = CustomButton(
        title: Constants.ChangeColorButtons.randomTitle
    )
    private let changeColorButtonsStack: UIStackView = UIStackView()

    // MARK: - Lifecycle
    init(delegate: WishMakerViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - Methods
    public func getColor() -> UIColor {
        color
    }
    
    // MARK: - SetUp
    private func setUp() {
        self.backgroundColor = Constants.View.backgroundColor
        setUpTitle()
        setUpDescription()
        setUpColorPicker()
        setUpMoveActionsStack()
        setUpSlidersStack()
        setUpChangeColorButtonsStack()
    }
    
    private func setUpTitle() {
        wishTitle.text = Constants.Title.text
        wishTitle.font =
            .systemFont(
                ofSize: Constants.Title.fontSize,
                weight: Constants.Title.fontWeight
            )
        wishTitle.textColor = Constants.Title.textColor
        
        addSubview(wishTitle)
        wishTitle.pinCenterX(to: self)
        wishTitle.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.Title.top)
    }
    
    private func setUpDescription() {
        wishDescription.text = Constants.Description.text
        wishDescription.textColor = Constants.Description.textColor
        wishDescription.numberOfLines = Constants.Description.numberOfLines
        
        addSubview(wishDescription)
        wishDescription.pinCenterX(to: self)
        wishDescription.pinHorizontal(to: self, Constants.Description.leading)
        wishDescription.pinTop(to: wishTitle.bottomAnchor, Constants.Description.top)
    }
    
    private func setUpColorPicker() {
        colorPicker.title = Constants.Picker.title
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = Constants.Picker.style
        colorPicker.overrideUserInterfaceStyle = Constants.Picker.interfaceStyle
    }
    
    private func setUpMoveActionsStack() {
        moveActionsStack.axis = Constants.MoveActions.axis
        moveActionsStack.spacing = Constants.MoveActions.spacing
        
        let buttons = [addWishesButton, scheduleWishesButton]
        let actions = [
            delegate?.presentWishStoringViewController,
            delegate?.pushWishCalendarViewController
        ]
        
        for i in 0..<buttons.count {
            buttons[i].action = actions[i]
            moveActionsStack.addArrangedSubview(buttons[i])
        }
        
        addSubview(moveActionsStack)
        moveActionsStack.pinBottom(to: safeAreaLayoutGuide.bottomAnchor, Constants.MoveActions.bottom)
        moveActionsStack.pinHorizontal(to: self, Constants.MoveActions.leading)
    }
    
    private func setUpSlidersStack() {
        slidersStack.axis = Constants.Sliders.axis
        slidersStack.layer.cornerRadius = Constants.Sliders.radius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            slidersStack.addArrangedSubview(slider)
            slider.valueChanged = { [weak self] in
                self?.slidersChangeBackgroundColor()
                slider.updateCurrentValue()
            }
        }
        
        addSubview(slidersStack)
        slidersStack.pinCenterX(to: self)
        slidersStack.pinLeft(to: safeAreaLayoutGuide.leadingAnchor, Constants.Sliders.leading)
        slidersStack.pinBottom(to: moveActionsStack.topAnchor, Constants.Sliders.bottom)
    }
    
    private func setUpChangeColorButtonsStack() {
        changeColorButtonsStack.axis = Constants.ChangeColorButtons.axis
        changeColorButtonsStack.spacing = Constants.ChangeColorButtons.spacing
        changeColorButtonsStack.distribution = Constants.ChangeColorButtons.distribution
        
        let buttons = [colorPickerButton, showHideButton, randomColorButton]
        let actions = [presentColorPicker, showHideSliders, randomChangeBackgroundColor]
        
        for i in 0..<buttons.count {
            buttons[i].action = actions[i]
            changeColorButtonsStack.addArrangedSubview(buttons[i])
        }
        
        addSubview(changeColorButtonsStack)
        changeColorButtonsStack.pinCenterX(to: self)
        changeColorButtonsStack.pinLeft(to: self, Constants.ChangeColorButtons.leading)
        changeColorButtonsStack.pinBottom(to: slidersStack.topAnchor, Constants.ChangeColorButtons.bottom)
    }
    
    // MARK: - Actions
    private func slidersChangeBackgroundColor() {
        self.color = UIColor(
            red: sliderRed.getValue(),
            green: sliderGreen.getValue(),
            blue: sliderBlue.getValue(),
            alpha: Constants.ChangeColorButtons.alpha
        )
    }
    
    private func presentColorPicker() {
        delegate?.presentColorPicker(colorPicker)
    }
    
    private func showHideSliders() {
        if slidersStack.isHidden {
            slidersStack.isHidden = false
            showHideButton.setTitle(Constants.ChangeColorButtons.hideTitle)
        } else {
            slidersStack.isHidden = true
            showHideButton.setTitle(Constants.ChangeColorButtons.showTitle)
        }
    }
    
    private func randomChangeBackgroundColor() {
        self.color = .random
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension WishMakerView: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(
        _ viewController: UIColorPickerViewController,
        didSelect color: UIColor,
        continuously: Bool
    ) {
        self.color = color
    }
}
