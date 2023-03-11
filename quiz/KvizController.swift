//
//  KvizController.swift
//  quiz
//
//  Created by crow on 10/03/2023.
//

import UIKit

class KvizController: UIViewController {

    @IBOutlet weak var image: UIImageView!
   
    @IBOutlet weak var otazkaLabel: UILabel!
    
    
    @IBOutlet var odpovedeButton: [UIButton]!
    
    
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    
    @IBOutlet weak var skoreLabel: UILabel!
    
    var otazky: [Kviz]?
    var kviz = ""
    var aktualnaOtazka = 0
    var spravnaOdpoved = ""
    var skore = 0
    var skoreText: String = ""
    var pomAktualnaOtazka = 0
    //nacita do pamate
    override func viewDidLoad() {
        super.viewDidLoad()
        print(kviz)
        // Do any additional setup after loading the view.
        
        loadJson()
        nacitajOtazku()
        
    }
    
    //kontrola odpovedi
    //ak je odpoved spravne je zelena inak cervena
    @IBAction func validate(_ sender: UIButton) {
        
        nextQuestionButton.isEnabled = true
        
        for odpoved in odpovedeButton{
            odpoved.disabledButtonStyle()
            if odpoved.currentTitle!.hasSuffix(spravnaOdpoved){
                odpoved.backgroundColor = Farby.zelena
            }
        }
        if sender.currentTitle!.hasSuffix(spravnaOdpoved){
            skore += 1
            //skoreLabel.text = "Aktualne skore je \(skore) / \(aktualnaOtazka)"
        }
        skoreLabel.isHidden = false
        pomAktualnaOtazka += 1
        skoreLabel.text = "Aktualne skore je \(skore) / \(pomAktualnaOtazka)"
    }
    
    
    
    
    
    //funkcia pre dalsiu otazku
    @IBAction func nextQuestion(_ sender: UIButton) {
        aktualnaOtazka += 1
       
        
        if aktualnaOtazka >= otazky!.count {
            
            let endKviz = UIAlertController(
                            title: "Koniec kvízu",
                            message:"Zahraj si dalsiu hru, tvoje skore je \(skore) / \(aktualnaOtazka)",
                            preferredStyle: .alert)
            
            endKviz.addAction(UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: { _ in
                                self.navigationController?.popViewController(animated: true)
                
                            }
            ))
            
            present(endKviz, animated: true)
            aktualnaOtazka = 0
        } else {
            if aktualnaOtazka == otazky!.count - 1{
                nextQuestionButton.setTitle("Vyhodnoť", for: .normal)
            }
            
            nacitajOtazku()
        }
    }
    
    func loadJson(){
        if let bundlePath = Bundle.main.path(forResource: kviz, ofType: nil),
            let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8),
           let parsedData = try? JSONDecoder().decode([Kviz].self, from: jsonData){
            otazky = parsedData.shuffled()
           }
    }
    
    func nacitajOtazku(){
        
        nextQuestionButton.isEnabled = false
        
        
        
        
        //spravna odpoved
        spravnaOdpoved = otazky![aktualnaOtazka].odpovede[0]
        
        image.image = UIImage(named: otazky![aktualnaOtazka].obrazok)
        otazkaLabel.text = "\(aktualnaOtazka + 1). \(otazky![aktualnaOtazka].otazka)"
        
        guard let rozhadzaneOdpovede = otazky?[aktualnaOtazka].odpovede.shuffled() else { return}
        
        if aktualnaOtazka == 0 {
            skoreLabel.isHidden = true
        }
        
        //do buttons vkladam nahodne usporiadane odpovede
        for odpovedeButton  in odpovedeButton {
            odpovedeButton.enabledButtonStyle()
            odpovedeButton.setTitle( "\(UnicodeScalar(UnicodeScalar("a").value + UInt32(odpovedeButton.tag))!)) \(rozhadzaneOdpovede[odpovedeButton.tag])", for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
