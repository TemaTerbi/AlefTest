//
//  ViewController.swift
//  AlefTest
//
//  Created by Артем Соловьев on 24.10.2022.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView()
    var currentIndexPathItem = 0
    var childItem: [String] = []
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "Персональные данные"
        label.font.withSize(20)
        return label
    }()
    
    private lazy var labelChild: UILabel = {
        var label = UILabel()
        label.text = "Дети (макс. 5)"
        label.font.withSize(20)
        return label
    }()
    
    private lazy var textFieldName: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.placeholder = "Имя"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private lazy var buttonAddChild: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.systemIndigo.cgColor
        button.setTitle("Добавить ребенка", for: .normal)
        button.tintColor = .systemIndigo
        button.setTitleColor(.systemIndigo, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonAllClear: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("Очистить", for: .normal)
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldAge: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.placeholder = "Возраст"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.keyboardType = .numberPad
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        setupConstraints()
        setupTableView()
        
        textFieldAge.delegate = self
        textFieldName.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChildCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func addSubView() {
        view.addSubview(label)
        view.addSubview(labelChild)
        view.addSubview(textFieldName)
        view.addSubview(textFieldAge)
        view.addSubview(buttonAddChild)
        view.addSubview(buttonAllClear)
        view.addSubview(tableView)
    }
    
    @objc private func addItem() {
        var countOfItem = childItem.count
        if countOfItem < 5 {
            let indexPath = NSIndexPath(row: childItem.count, section: 0)
            childItem.append("item\(childItem.count + 1)")
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath as! IndexPath], with: .left)
            tableView.endUpdates()
        } else {
            showActionSheet(title: "Ошибка!", message: "Нельзя добавить больше 5 детей!", style: .alert)
        }
    }
    
    @objc private func clearAll() {
        showActionSheet(title: "Удалить все", message: "Вы действительно хотите все удалить?", style: .actionSheet)
    }
    
    private func showActionSheet(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertOk = UIAlertAction(title: "Ok", style: .destructive) { _ in
            if style == .actionSheet {
                self.textFieldAge.text = ""
                self.textFieldName.text = ""
                var count = 0
                for i in self.childItem {
                    let index = IndexPath(row: count, section: 0)
                    let cell = self.tableView.cellForRow(at: index) as! ChildCell
                    cell.textFieldName.text = ""
                    cell.textFieldAge.text = ""
                    count += 1
                }
                self.childItem.removeAll()
                self.tableView.reloadData()
            } else { }
        }
        
        if style == .actionSheet {
            let alertCancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            }
            alert.addAction(alertCancel)
        }
        
        alert.addAction(alertOk)
        self.present(alert, animated: true)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(70)
        }
        
        textFieldName.snp.makeConstraints { make in
            make.top.equalTo(label.snp_bottomMargin).inset(-30)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        textFieldAge.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp_bottomMargin).inset(-15)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        labelChild.snp.makeConstraints { make in
            make.top.equalTo(textFieldAge.snp_bottomMargin).inset(-45)
            make.left.equalToSuperview().inset(20)
        }
        
        buttonAddChild.snp.makeConstraints { make in
            make.top.equalTo(textFieldAge.snp_bottomMargin).inset(-30)
            make.left.equalTo(labelChild.snp_rightMargin).inset(-9)
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        
        buttonAllClear.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonAddChild.snp_bottomMargin).inset(-30)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonAllClear.snp_topMargin).inset(-30)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    //Ограничение для поля возраст. Нельзя ввести больше двух символов
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textFieldAge {
            let maxLength = 2
            let currentString: NSString = textField.text as! NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxLength
        } else {
            return true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChildCell
        cell.selectionStyle = .none
        cell.delegateCell = self
        cell.indexPath = indexPath
        return cell
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: CellDelegate {
    func didTapCell(index: IndexPath, isNow: Bool) {
        let cell = tableView.cellForRow(at: index) as! ChildCell
        cell.textFieldName.text = ""
        cell.textFieldAge.text = ""
        currentIndexPathItem = index.row
        childItem.remove(at: currentIndexPathItem)
        tableView.beginUpdates()
        tableView.deleteRows(at: [index], with: .right)
        tableView.endUpdates()
        tableView.reloadData()
    }
}

