//
//  FirstViewController.swift
//  jokesNorris
//
//  Created by Вячеслав Николаев on 18.11.2019.
//  Copyright © 2019 Вячеслав Николаев. All rights reserved.
//

import UIKit

struct Jokes : Codable {
    let type : String
    let value : [Joke]
}

struct Joke : Codable {
    let id : Int
    let joke : String
    let categories: [String]!
}

class FirstViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonLoad)
        setupButtonLoad()
        
        view.addSubview(textFieldJokes)
        setupTextFieldJokes()
        
        view.addSubview(labelShowJokes)
        setupLabelShowJokes()
        
        //скрыть клавиатуру при тапе по экрану
        let hideKeyboard = UITapGestureRecognizer(target: self, action: Selector(("touchHideKeyboard")))
        view.addGestureRecognizer(hideKeyboard)
        
        //смещение контента вверх при открытии клавиатуры:
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        buttonLoad.addTarget(self, action: #selector(loadJokes), for: .touchUpInside)
        textFieldJokes.addTarget(self, action: #selector(textFieldIsEmpty), for: .editingChanged)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func touchHideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func loadJokes(sender: UIButton!) {
        let count = Int(textFieldJokes.text!)!
        guard let url = URL(string: "https://api.icndb.com/jokes/random/\(count)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let jokes = try JSONDecoder().decode(Jokes.self, from: data)
                var someJokes = ""
                for i in jokes.value {
                    someJokes += i.joke + "\n\n"
                }
                DispatchQueue.main.async {
                    self.labelShowJokes.text = someJokes
                }
            } catch {
                //print(error)
            }
        }.resume()
    }
    
    let buttonLoad: UIButton = {
        let button = UIButton()
        button.setTitle("LOAD", for: .normal)
        button.backgroundColor = UIColor.init(displayP3Red: 48/255, green: 123/255, blue: 246/255, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupButtonLoad() {
        buttonLoad.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        buttonLoad.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonLoad.widthAnchor.constraint(equalToConstant: 110).isActive = true
        buttonLoad.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    var textFieldJokes : UITextField! = {
        let textFieldJokes = UITextField()
        textFieldJokes.placeholder = "Input count..."
        textFieldJokes.translatesAutoresizingMaskIntoConstraints = false
        textFieldJokes.keyboardType = .decimalPad
        return textFieldJokes
    }()
    
    func setupTextFieldJokes() {
        textFieldJokes.bottomAnchor.constraint(equalTo: buttonLoad.topAnchor, constant: -10).isActive = true
        textFieldJokes.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textFieldJokes.widthAnchor.constraint(equalToConstant: 120).isActive = true
        textFieldJokes.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    let labelShowJokes: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupLabelShowJokes() {
        labelShowJokes.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        labelShowJokes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        labelShowJokes.widthAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true
        labelShowJokes.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //buttonLoad будет неактивной, пока поле textFieldJokes пустое:
    @objc func textFieldIsEmpty() {
        if textFieldJokes.text?.isEmpty == false {
            buttonLoad.isEnabled = true
        } else {
           buttonLoad.isEnabled = false
        }
    }
}
