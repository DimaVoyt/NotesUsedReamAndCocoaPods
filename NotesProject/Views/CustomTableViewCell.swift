//
//  CustomTableViewCell.swift
//  NotesProject
//
//  Created by Дмитрий Войтович on 04.05.2022.
//

import Foundation
import UIKit
class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    
    private let NoteNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let NoteTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [NoteNameLabel, NoteTextLabel])
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with name: String, text: String) {
        NoteNameLabel.text = name
        NoteTextLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        NoteNameLabel.text = nil
    }
    
    
    
    func setupConstraints() {
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }
}
