//
//  TitleCell.swift
//  PagViewController
//
//  Created by Rath! on 30/4/24.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    static let identifier = "TitleCell"
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

   private let viewLine: UIView = {
        let viewLine = UIView()
        viewLine.translatesAutoresizingMaskIntoConstraints = false
        viewLine.backgroundColor = .clear
        return viewLine
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView(){
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblTitle)
        addSubview(viewLine)
        NSLayoutConstraint.activate([
            lblTitle.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
            lblTitle.rightAnchor.constraint(equalTo: rightAnchor,constant: -5),
            lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            //----
            viewLine.heightAnchor.constraint(equalToConstant: 2),
            viewLine.leftAnchor.constraint(equalTo: lblTitle.leftAnchor,constant: -5),
            viewLine.rightAnchor.constraint(equalTo: lblTitle.rightAnchor,constant: 5),
            viewLine.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
        ])
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                lblTitle.textColor = .red
                viewLine.backgroundColor = .orange
            }
            else{
                lblTitle.textColor = .black
                viewLine.backgroundColor = .clear
            }
        }
    }
}
