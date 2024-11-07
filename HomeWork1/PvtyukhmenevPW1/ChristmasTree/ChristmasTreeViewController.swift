//
//  ViewController.swift
//  HomeWork1
//
//  Created by Peter on 09.10.2024.
//

import UIKit

final class ChristmasTreeViewController: UIViewController {
    //MARK: - Constants
    private enum Constant {
        static let defaultRadius: CGFloat = 8
        static let defaultBorder: CGFloat = 2
        static let defaultDuration: TimeInterval = 0.4
    }
    
    //MARK: - Variables
    @IBOutlet var lights: [UIView]!
    @IBOutlet var otherViews: [UIView]!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: - Actions
    @IBAction func buttonWasPressed(_ sender: Any) {
        let button = sender as? UIButton
        let colors = getUniqueColors()
        button?.isEnabled = false
        var delay = 0.0
        
        for i in 0..<lights.count {
                UIView.animate(
                    withDuration: Constant.defaultDuration, delay: delay,
                    animations: {
                        self.changeLightView(view: self.lights[i], randomColor: colors[i])
                    }, completion: { _ in
                        if i == self.lights.count - 1 {
                            button?.isEnabled = true
                        }
                    }
                )
            delay += Constant.defaultDuration
        }
    }
    
    //MARK: - Private methods
    private func setUpViews() {
        let colors = getUniqueColors()
        for view in otherViews {
            view.layer.cornerRadius = Constant.defaultRadius
            view.layer.borderWidth = Constant.defaultBorder
            view.layer.borderColor = UIColor.black.cgColor
        }
        
        for i in 0..<lights.count {
            changeLightView(view: lights[i], randomColor: colors[i])
        }
    }
    
    private func changeLightView(view light: UIView, randomColor color: UIColor) {
        light.backgroundColor = color
        light.layer.cornerRadius = getRandomRadius()
        light.layer.borderWidth = Constant.defaultBorder
        light.layer.borderColor = UIColor.black.cgColor
    }
    
    private func getUniqueColors() -> [UIColor] {
        var set: Set<UIColor> = []
        while set.count < lights.count {
            set.insert(UIColor.random)
        }
        
        return Array(set)
    }
    
    private func getRandomRadius() -> CGFloat {
        return .random(in: 10...30)
    }
}


