//
//  ChildCell.swift
//  AlefTest
//
//  Created by Артем Соловьев on 24.10.2022.
//


import UIKit

protocol CellDelegate: class {
    func didTapCell(index: IndexPath, isNow: Bool)
}

class ChildCell: UITableViewCell {
    
    var delegateCell:CellDelegate?
    var indexPath:IndexPath?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    lazy var textFieldName: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.placeholder = "Имя"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    lazy var textFieldAge: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.placeholder = "Возраст"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.keyboardType = .numberPad
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private lazy var buttonDeleteChild: UIButton = {
        var button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(.systemIndigo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(selectionStyle, action: #selector(deleteItem), for: .touchUpInside)
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewInContentView() {
        self.contentView.addSubview(mainView)
        mainView.addSubview(textFieldAge)
        mainView.addSubview(textFieldName)
        mainView.addSubview(buttonDeleteChild)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        textFieldName.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        textFieldAge.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp_bottomMargin).inset(-15)
            make.height.equalTo(50)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(120)
        }
        
        buttonDeleteChild.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.left.equalTo(textFieldName.snp_rightMargin).inset(-10)
            make.width.equalTo(120)
        }
    }
    
    @objc private func deleteItem() {
        delegateCell?.didTapCell(index: indexPath!, isNow: false)
    }
    
    private func configureCell() {
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(150)
        }
        textFieldAge.delegate = self
        addSubviewInContentView()
        setupConstraints()
    }
}

extension ChildCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 2
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
