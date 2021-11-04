//
//  LoginViewController.swift
//  TestingPyramid
//
//  Created by Hassaan El-Garem on 11/9/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK:- Error Strings
    
    static let emptyStateError = "Either email or password are empty"
    static let defaultError = "Unkown error occured"
    
    // MARK:- Outlets

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
    }
    
    // MARK:- Actions
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showError(Self.emptyStateError)
            return
        }
        LoginManager.shared.login(email: email, password: password) { (success, error) in
            guard success else {
                showError(error ?? Self.defaultError)
                return
            }
            navigateToStatistics()
        }
    }
    
    @IBAction func backgroundViewTapped(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK:- Helpers
    
    private func navigateToStatistics() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.kLoginToStatisticsSegueIdentifier, sender: nil)
        }
    }
    
    private func showError(_ error: String) {
        let alert = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setupAccessibilityIdentifiers() {
        welcomeLabel.accessibilityIdentifier = AccessibilityIdentifiers.kLoginWelcomeLabelIdentifier
        emailTextField.accessibilityIdentifier = AccessibilityIdentifiers.kLoginEmailTextFieldIdentifier
        passwordTextField.accessibilityIdentifier = AccessibilityIdentifiers.kLoginPasswordTextFieldIdentifier
        loginButton.accessibilityIdentifier = AccessibilityIdentifiers.kLoginButtonIdentifier
    }

}
