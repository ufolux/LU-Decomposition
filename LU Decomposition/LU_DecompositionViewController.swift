//
//  LU_DecompositionViewController.swift
//  LU Decomposition
//
//  Created by NASA on 6/11/14.
//  Copyright (c) 2014 鲁鑫. All rights reserved.
//

import Foundation

import UIKit


class LU_DecompositionViewController: UIViewController,UITextFieldDelegate{
    
    
    
    
    
    @IBOutlet var tf_MatrixOrder: UITextField
    
    @IBOutlet var btn_Apply : UIButton
    
    @IBOutlet var btn_Calculate : UIButton
    

    
    @IBOutlet var sv_rows : UIScrollView

    
    
    var matrixOrder: Int = 0
    var Matrix = MatrixEntity()
    
    func addTextFieldIntoScrollView(scrollView: UIScrollView,index: Int) {
        var y:Int = 15 + (index - 1) * 40
        
        var textField = UITextField(frame:CGRect(x: 80, y: y, width: 200, height: 30))
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = "input number 1,2,3,4..."
        textField.tag = index
        textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.Done
        scrollView.addSubview(textField)
    }
    
    
    func addLabelIntoScrollView(scrollView: UIScrollView,index: Int) {
        var y:Int = 15 + (index - 1) * 40
        
        var label = UILabel(frame:CGRect(x: 20,y: y,width: 50,height: 30))
        label.backgroundColor = UIColor.whiteColor()
        label.text = "row\(index)"
        
        
        scrollView.addSubview(label)
    }
    
    
    @IBAction func LUCalculate(sender : UIButton) {
        
        if  matrixOrder != 0 {
            
            for var i = 1; i <= matrixOrder; i++ {
                //force convert
                var tf_row = sv_rows.viewWithTag(i) as UITextField
                var row:String = tf_row.text
                var rowString:NSString[] = row.componentsSeparatedByString(",")//row string array
                
                for var j = 1; j <= rowString.count ; j++ {
                    
                        Matrix[i,j] = rowString[j - 1].doubleValue//to double
                }
                    
            }
        
            
    
        
        var matrixEntity:MatrixEntity = self.Matrix
        
        var resultView = LU_ResultViewController()
        resultView.matrixEntity = matrixEntity
        //set Value to matrixEntity
        self.presentModalViewController(resultView,animated: true)
        }else {
            
        }
    
    }
    
    @IBAction func ApplyMartrixOrder(sender: UIButton) {
        var i:Int = 0
        
        if var order = tf_MatrixOrder.text.toInt() {
            matrixOrder = order
            Matrix = MatrixEntity(matrixOrder: order + 1)
            var subviewsArray = self.sv_rows.subviews
            //remove all subviews from the ScrollView
            for subview: AnyObject in subviewsArray {
                subview.removeFromSuperview()
            }
            //add views
            for i = 1; i <= order; i++ {
                self.addLabelIntoScrollView(sv_rows,index: i)
                self.addTextFieldIntoScrollView(sv_rows,index: i)
                
            }
            
            var height:Int = (i+5) * 40
            self.sv_rows.contentSize = CGSize(width: 320,height: height)
            
        }else{
            
            tf_MatrixOrder.text = ""
            
            return
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    @IBAction func textFiledReturnEditing(sender: AnyObject){
        self.view.endEditing(true)
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
}
