//
//  LU_ResultViewController.swift
//  LU Decomposition
//
//  Created by NASA on 6/11/14.
//  Copyright (c) 2014 鲁鑫. All rights reserved.
//

import Foundation
import UIKit


class LU_ResultViewController: UIViewController{

   
    @IBOutlet var sv_matrix : UIScrollView
    
    var matrixEntity = MatrixEntity()
    var matrixOrder = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //get order
        self.matrixOrder = matrixEntity.matrix_order - 1
        //end
        
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        //add title
        self.addTitleLabel()
        //end
        
        //add done button
        self.addDoneButton()
        //end
        
        //scrollview
        self.addScrollview()
        sv_matrix = view.viewWithTag(-1) as UIScrollView
        //end
        
        //dra0w formula label
        self.addOriginFormula(matrixEntity)
        self.addResultMatrix(matrixEntity)
        //end
    }
    
    //add scrollView
    func addScrollview() {
        //set contentSize
        var height:Int = 80*(matrixOrder+3)
        //end
        var scrollView = UIScrollView(frame:CGRectMake(0.0, 65.0, 320.0, 400.0))
        scrollView.contentSize = CGSize(width: 320,height: height)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.tag = -1
        self.view.addSubview(scrollView)
    }
    
    //add done button
    func addDoneButton() {
        var button = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        button!.frame = CGRectMake(10.0, 30.0, 60.0, 40.0)
        button!.backgroundColor = UIColor.whiteColor()
        button?.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        button?.setTitle("Done", forState: UIControlState.Normal)
        button?.setTitle("Done", forState: UIControlState.Highlighted)
        button?.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside)
        button!.tag = 100
        self.view.addSubview(button)
    }
    
    //title Label
    func addTitleLabel() {
        // Label
        var titleLabel = UILabel(frame: CGRect(x:60,y:25,width:200,height:40))
        titleLabel.backgroundColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(18)
        titleLabel.text = "Result - By 鲁鑫"
        self.view.addSubview(titleLabel)
    }
    

    //Origin Formula
    func addOriginFormula(matrixEntity: MatrixEntity) {
        var numStr = String()
        var lines = self.matrixOrder + 3
        
        var label = UILabel(frame: CGRect(x: 10,y: 10,width: 500,height: 20*lines))
        label.backgroundColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont.systemFontOfSize(20)
        
        //ger lines number of textField
        label.numberOfLines = lines
        //end
        
        //input numbers into label text
        numStr = "Origin Matrix \n"
        for var i = 1; i <= self.matrixOrder; i++ {
            for var j = 1; j <= self.matrixOrder; j++ {
                numStr += "\(matrixEntity[i,j])"
                numStr += "  "
            }
            numStr += "\n"
            }
            
        label.text = numStr
        self.sv_matrix.addSubview(label)

    }
    
    //Result Matrix
    func addResultMatrix(matrixEntity: MatrixEntity) {

        var LUTuple = LUDecomposition(matrixEntity)
        var L = LUTuple.0
        var U = LUTuple.1
        var lines = self.matrixOrder + 3
        // add L
        var numStrL = String()
        var labelL = UILabel(frame: CGRect(x:10,y:10+lines*20,width:500,height:20*lines))/*self.view.bounds*/
        labelL.backgroundColor = UIColor.whiteColor()
        labelL.textAlignment = NSTextAlignment.Left
        labelL.font = UIFont.systemFontOfSize(20)
        
        //ger lines number of textField
        labelL.numberOfLines = self.matrixOrder + 1
        //end
        
        //input numbers into labelL text
        numStrL = "Matrix L \n"
        for var i = 1; i <= matrixOrder; i++ {
            for var j = 1; j <= matrixOrder; j++ {
                numStrL += "\(L[i,j])"
                numStrL += "  "
            }
            numStrL += "\n"
        }
        
        labelL.text = numStrL
        self.sv_matrix.addSubview(labelL)
        
        //add U
        var numStrU = String()
        var labelU = UILabel(frame: CGRect(x:10,y:10+lines*20*2,width:500,height:20*lines)/*self.view.bounds*/)
        labelU.backgroundColor = UIColor.whiteColor()
        labelU.textAlignment = NSTextAlignment.Left
        labelU.font = UIFont.systemFontOfSize(20)
        
        //ger lines number of textField
        labelU.numberOfLines = self.matrixOrder + 1
        //end
        
        //input numbers into label text
        numStrU = "Matrix U \n"
        for var i = 1; i <= matrixOrder; i++ {
            for var j = 1; j <= matrixOrder; j++ {
                numStrU += "\(U[i,j])"
                numStrU += "  "
            }
            numStrU += "\n"
        }
        
        labelU.text = numStrU
        self.sv_matrix.addSubview(labelU)
    }
    
    //LU Decomposition
    func LUDecomposition(matrixEntity: MatrixEntity)->(MatrixEntity,MatrixEntity) {
        
        var L = MatrixEntity(matrixOrder: matrixOrder + 1)
        var U = MatrixEntity(matrixOrder: matrixOrder + 1)
        var s1:Double = 0.0 ,s2:Double = 0.0
        var i:Int = 0,j:Int = 0,k:Int = 0,r:Int = 0,s = 1
        
        for i = 1; i <= matrixOrder; i++ {
            for j = 1; j <= matrixOrder; j++ {
                if i == j {
                    L[i,j] = 1
                }
            }
        }
        
        for j = 1; j <= matrixOrder; j++ {
            U[1,j] = matrixEntity[1,j]
            L[j,1] = matrixEntity[j,1]/U[1,1]
        }
        
        for r = 2; r <= matrixOrder; r++ {
            for j = r; j <= matrixOrder; j++ {
                for k = 1; k <= r - 1; k++ {
                    s1 += L[r,k]*U[k,j]
                }
                U[r,j] = matrixEntity[r,j] - s1
                s1 = 0
                
            }
            
            for i = r+1; i <= matrixOrder; i++ {
                for k = 1; k < r; k++ {
                    s1 += L[i,k]*U[k,r]
                }
                
                L[i,r] = matrixEntity[i,r] - s1
                L[i,r] = L[i,r]/U[r,r]
                
                s1 = 0
            }
        }

    return (L,U)
}
    
    func doneButton(sender: UIBarButtonItem) {
        self.dismissModalViewControllerAnimated( true )
    }
}

