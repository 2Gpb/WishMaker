//
//  Extansions.swift
//  HomeWork1
//
//  Created by Peter on 09.10.2024.
//
import UIKit

//MARK: - Random color
extension UIColor {
    static var random: UIColor {
        .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
