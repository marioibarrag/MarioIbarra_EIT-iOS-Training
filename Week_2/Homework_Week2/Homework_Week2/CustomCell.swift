//
//  CustomCell.swift
//  Homework_Week2
//
//  Created by Consultant on 3/28/22.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var idLabel = UILabel()
    var statusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "CustomCell")
        self.accessoryType = .disclosureIndicator
        
        addSubview(idLabel)
        addSubview(statusLabel)
        
        setIdLabelConstraints()
        setStatusLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLabelsText(photoId: Int?, status: String?) {
        idLabel.text = "ID: \(photoId ?? 0)"
        statusLabel.text = "Status: \(status ?? "")"
    }
    
    private func setIdLabelConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    private func setStatusLabelConstraints() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
