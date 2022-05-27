//
//  NoteInfoViewController.swift
//  NotesProject
//
//  Created by Дмитрий Войтович on 04.05.2022.
//

import UIKit
import RealmSwift

class NoteInfoViewController: UIViewController {
    
    private let notesInfo: RealmObjectNotesInfo
    
    let realm = try! Realm()
    
    let manipulationNoteService = ManipulationNoteService()
    
    init(notesInfo: RealmObjectNotesInfo) {
        self.notesInfo = notesInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewNoteInf: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteText: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.white
        tv.font = .systemFont(ofSize: 25, weight: .thin)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save changes", for: .normal)
        button.backgroundColor = UIColor.brown
        button.tintColor = UIColor.systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        noteText.text = notesInfo.noteText
        setupKeyboardHandlers()
        setupConstraints()
        setupButton()
    }
    
    var saveChangesButtonBottomAnchor: NSLayoutConstraint?
    
    func setupKeyboardHandlers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: handleKeyboardWillShow)
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: handleKeyboardWillHide
        )
    }

    func handleKeyboardWillShow(
        notification: Notification
    ) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let height = keyboardFrame.cgRectValue.height
        saveChangesButtonBottomAnchor?.constant = -height + safeAreaInsets.bottom
    }
    
    func handleKeyboardWillHide(
        notification: Notification
    ) {
        saveChangesButtonBottomAnchor?.constant = -12
    }
    
    func setupButton() {
        saveChangesButton.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
    }
    @objc func saveInfo() {
        if notesInfo.noteText == noteText.text {
            navigationController?.popViewController(animated: true)
        } else {
            manipulationNoteService.updateNote(id: notesInfo.id) {
                $0.noteText = noteText.text
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setupConstraints() {
        view.addSubview(viewNoteInf)
        viewNoteInf.addSubview(noteText)
        view.addSubview(saveChangesButton)
        
        viewNoteInf.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewNoteInf.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewNoteInf.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewNoteInf.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        noteText.topAnchor.constraint(equalTo: viewNoteInf.topAnchor).isActive = true
        noteText.bottomAnchor.constraint(equalTo: viewNoteInf.bottomAnchor, constant: -100).isActive = true
        noteText.leftAnchor.constraint(equalTo: viewNoteInf.leftAnchor).isActive = true
        noteText.rightAnchor.constraint(equalTo: viewNoteInf.rightAnchor).isActive = true

        saveChangesButtonBottomAnchor = saveChangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
            saveChangesButtonBottomAnchor?.isActive = true
        saveChangesButton.centerXAnchor.constraint(equalTo: viewNoteInf.centerXAnchor).isActive = true
    }


}

var safeAreaInsets: UIEdgeInsets {
    let window = UIApplication.shared.keyWindow
    return window?.safeAreaInsets ?? .zero
}
