//
//  ViewController.swift
//  quiz
//
//  Created by crow on 10/03/2023.
//

import UIKit

class PickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    
    @IBOutlet weak var kvizPicker: UIPickerView!
    var kvizArray = [String]()
    var vybratyKviz = "" //kviz, ktorý si použivatel vyberie
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any addition
       
        overrideUserInterfaceStyle = .light
        
        let path = Bundle.main.resourcePath!
        let items = try! FileManager.default.contentsOfDirectory(atPath: path)
        
        //nacitavam subory a ak je subor Kviz X... tak ho prirad do pola
        for item in items where item.hasPrefix("Kviz "){
            kvizArray.append(item)
            
        }
        kvizArray.sort()
        
        //naplenie pickeru datami
        kvizPicker.dataSource = self
        kvizPicker.delegate = self
        vybratyKviz = kvizArray[0]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let kvizController = segue.destination as? KvizController {
            kvizController.kviz = vybratyKviz
        }
    }
    
//kolko komponentov bude obsahovat na 1 riadok
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pocet riadkov v ktorych bude obsah, 5 kvízov je 5 riadkov
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kvizArray.count
    }

    //sluzi na zobrazenie jednotliveho riadka
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //row je index aktualneho riadku
        //rozdeli nazov podla bodky, aby tam bol iba Kviz 1 a nie Kviz 1.json
        let rozdel = kvizArray[row].components(separatedBy: ".")
        return rozdel[0]
        
    }
    
    
    //ktory riadok sme klikli
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        vybratyKviz = kvizArray[row]
    }
}

