//
//  AddNoteViewController.swift
//  NotesProject
//
//  Created by Дмитрий Войтович on 04.05.2022.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    let manipulationNoteService = ManipulationNoteService()
    
    let viewForTextField: UIView = {
        let viewFirst = UIView()
        viewFirst.backgroundColor = UIColor.white
        viewFirst.translatesAutoresizingMaskIntoConstraints = false
        return viewFirst
    }()
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "Note name"
        name.font = .systemFont(ofSize: 20)
        name.backgroundColor = UIColor.white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let viewForNoteText: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteText: UITextView = {
        let noteText = UITextView()
        noteText.font = .systemFont(ofSize: 15)
        noteText.backgroundColor = UIColor.white
        noteText.translatesAutoresizingMaskIntoConstraints = false
        return noteText
    }()
    
    let saveNoteInformationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.tintColor = UIColor.systemOrange
        return button
    }()
    
    
    private var saveNoteInformationButtonBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        setupConstraints()
        setupKeyboardWillShow()
        setupKeyboardWillHide()
        setupButtons()
    }
    
    private func setupButtons() {
        saveNoteInformationButton.addTarget(self, action: #selector(saveInfoNotes), for: .touchUpInside)
        
    }
    
    @objc
    private func saveInfoNotes() {
        if let nameText = nameTextField.text, let noteText = noteText.text {
            if nameText.isEmpty || noteText.isEmpty {
                let controller = UIAlertController(title: "Oops...", message: "Sorry, you need to fill in all the information", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
                return
            }
            
            manipulationNoteService.saveInfoNotes(nameText: nameText, noteText: noteText)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(viewForTextField)
        viewForTextField.addSubview(nameTextField)
        view.addSubview(viewForNoteText)
        viewForNoteText.addSubview(noteText)
        view.addSubview(saveNoteInformationButton)
        
        viewForTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewForTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        viewForTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        viewForTextField.heightAnchor.constraint(equalToConstant: 65).isActive = true
        viewForTextField.layer.cornerRadius = 16
        
        nameTextField.topAnchor.constraint(equalTo: viewForTextField.topAnchor, constant: 12).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: -12).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: viewForTextField.leftAnchor, constant: 12).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: viewForTextField.rightAnchor, constant: -12).isActive = true
        
        viewForNoteText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewForNoteText.topAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: 8).isActive = true
        viewForNoteText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        viewForNoteText.heightAnchor.constraint(equalToConstant: 350).isActive = true
        viewForNoteText.layer.cornerRadius = 22
        
        noteText.topAnchor.constraint(equalTo: viewForNoteText.topAnchor, constant: 12).isActive = true
        noteText.bottomAnchor.constraint(equalTo: viewForNoteText.bottomAnchor, constant: -12).isActive = true
        noteText.leftAnchor.constraint(equalTo: viewForNoteText.leftAnchor, constant: 12).isActive = true
        noteText.rightAnchor.constraint(equalTo: viewForNoteText.rightAnchor, constant: -12).isActive = true
        
        saveNoteInformationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveNoteInformationButtonBottomAnchor = saveNoteInformationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        saveNoteInformationButtonBottomAnchor?.isActive = true
        saveNoteInformationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveNoteInformationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        saveNoteInformationButton.layer.cornerRadius = 15
        
    }
    
    func setupKeyboardWillShow() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: handleKeyboardWillShow)
    }
    
    func handleKeyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let height = keyboardFrame.cgRectValue.height
        saveNoteInformationButtonBottomAnchor?.constant = -height
    }
    
    func setupKeyboardWillHide() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: handleKeyboardWillHide)
    }
    func handleKeyboardWillHide(notification: Notification) {
        //        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        //        let height = keyboardFrame.cgRectValue.height
        saveNoteInformationButtonBottomAnchor?.constant = -50
        
    }
    
    
}
