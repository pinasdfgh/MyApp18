//
//  ViewController.swift
//  MyApp18
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    
    var ai:UIActivityIndicatorView?
    
    @IBOutlet weak var img: UIImageView!
    
    @IBAction func btn1(_ sender: Any) {
        let url = URL(string: "http://freedesignfile.com/upload/2016/11/Golden-background-with-abstract-shiny-vector.jpg")
        let req = URLRequest(url: url!)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req, completionHandler: {(data,rep,error) in
            if error == nil{
                print("ok")
                self.saveFile(data: data!)
                DispatchQueue.main.async {
                    self.showImg(data: data!)
                }
            }else{
                print("NG")
            }
        
        })
        
        task.resume()
    }
    
    private func saveFile(data:Data){
        let imgFile = docDir + "/bg.jpg"
        let url = URL(fileURLWithPath: imgFile)
        do{
            try data.write(to: url)
            print("save OK")
        }catch{
            print(error)
        }
    }
    private func showImg(data:Data){
//        let image = UIImage(data: data)
//        img.image = image
        let imgFile = docDir + "/bg.jpg"
        guard fmgr.fileExists(atPath: imgFile) else{
            return
        }
        let imgtemp = UIImage(contentsOfFile: imgFile)
        img.image = imgtemp
    }
    
    @IBOutlet weak var webvc: UIWebView!
    
    @IBAction func btn2(_ sender: Any) {
        ai = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        ai?.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        ai?.startAnimating()
        view.addSubview(ai!)
        
        let url = URL(string: "http://pdfmyurl.com/?url=http://www.gamer.com.tw")
        let req = URLRequest(url: url!)
        
        webvc.loadRequest(req)
        let session = URLSession(configuration: .default)
        let task = session.downloadTask(with: req, completionHandler: {(data,rep,error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.savePDF(data!)
                    self.ai?.removeFromSuperview()
                }
                
            }
        })
        task.resume()
    }
    private func savePDF(_ data:URL){
        
      
        let newPDF = docDir + "/d.pdf"
        let target = URL(fileURLWithPath: newPDF)
        do{
            try fmgr.copyItem(at: data, to: target)
        }catch{
            print(error)
        }
        
        
    }
    
    @IBAction func btn3(_ sender: Any) {
        
    }
    
    @IBAction func btn4(_ sender: Any) {
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(docDir)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

