//
//  MatrixEntity.swift
//  LU Decomposition
//
//  Created by NASA on 6/12/14.
//  Copyright (c) 2014 鲁鑫. All rights reserved.
//

import Foundation

struct MatrixEntity {
    var rows: Int, columns: Int
    var matrix_order: Int
    var grid: Double[]

    
    init(){
        rows = 0
        columns = 0
        matrix_order = 0
        grid = Double[]()
    }
    
    init(matrixOrder: Int) {
        self.rows = matrixOrder
        self.columns = matrixOrder
        self.matrix_order = matrixOrder
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}



