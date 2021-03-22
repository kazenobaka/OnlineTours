//
//  ViewController.swift
//  OnlineTours
//
//  Created by Алексей on 30.11.2020.
//  Copyright © 2020 Алексей. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CitySelectionViewControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.default
        navigationBar?.tintColor = UIColor.orange
    }
    
    
    func didSelectedCity(city: Country) {
        
        let countryName = city.countryName
        let name = city.name
       
        let color = UIColor.gray
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        let attributedCountryName =
            NSAttributedString(string: countryName ?? "", attributes: attributes)
        
        let attributedName = NSAttributedString(string: name + ", ")
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(attributedName)
        attributedText.append(attributedCountryName)
        selectedTextField?.attributedText = attributedText
    }
    
    var selectedTextField: UITextField?
    
    @IBOutlet var textLabelFrom: UITextField!
    @IBOutlet var textLabelTo: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabelFrom.delegate = self
        textLabelTo.delegate = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.isTranslucent = true
        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextField = textField
        performSegue(withIdentifier: "ShowDepatCitiesPicker", sender: nil)
        return false
    }
    
    @IBAction func didTouchFindTourButton (sender: UIButton) {
        performSegue(withIdentifier: "FindTour", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CitySelectionViewController {
            dest.delegate = self
            
        } else if let dest = segue.destination as? ToursViewController {
            
        }
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}
