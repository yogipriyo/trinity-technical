//
//  ContactDetailsViewController.swift
//  Trinity Technical
//
//  Created by Yogi Priyo Prayogo on 15/04/23.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    
    private let contact: Contact
    
    init(_ contact: Contact) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Based on the design, the contact form can be built by using table view that has section but for the sake of saving time in this test and the low number of the fields, it will be much quicker to do it manually
        
        setupContent()
        setupViews()
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
        case self.lastNameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.dobTextField.becomeFirstResponder()
        default:
            self.firstNameTextField.resignFirstResponder()
        }
    }
    
    private func setupViews() {
        contactImage.tintColor = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0/255.0, alpha: 1.0)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        dobTextField.delegate = self
    }
    
    private func setupContent() {
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        emailTextField.text = contact.email
        dobTextField.text = contact.dob
    }
    
    private func setupNavbar() {
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        navigationItem.leftBarButtonItems = [cancel]
        navigationItem.rightBarButtonItems = [save]
    }
    
    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveTapped() {
        // to do it properly for the update list when going back from this screen, there should be a data store that is independent.
        // much like redux concept. so this function will update the data on the store using action or anything similar.
        // then set the homepage to prioritize getting the data from that data store and put the getting data from json file to the
        // second priority when the data store is empty
        // then implement the pull to refresh on the collection view to get the data from the json file again
        // I can do that but unfortunately not within the 2 hours timeframe
    }

}

extension ContactDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
}
