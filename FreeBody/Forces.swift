//
//  Forces.swift
//  FreeBody
//
//  Created by Conner DiPaolo on 1/3/15.
//  Copyright (c) 2015 Applications of Computer Science Club. All rights reserved.
//

import Darwin
import SpriteKit

extension UIBezierPath {
    
    // creates an arrow shaped path with middle of base as start point and pointed end as end point
    class func arrowPath(tailLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat) -> UIBezierPath {
        
        let midY: CGFloat = tailWidth / 2
        
        var polygonPath = UIBezierPath()
        polygonPath.moveToPoint(CGPointMake(0, 0))
        polygonPath.addLineToPoint(CGPointMake( 0, -midY))
        polygonPath.addLineToPoint(CGPointMake( tailLength, -midY))
        polygonPath.addLineToPoint(CGPointMake( tailLength, -headWidth))
        polygonPath.addLineToPoint(CGPointMake( tailLength + headWidth, 0))
        polygonPath.addLineToPoint(CGPointMake( tailLength, headWidth))
        polygonPath.addLineToPoint(CGPointMake( tailLength, midY))
        polygonPath.addLineToPoint(CGPointMake( 0, midY))
        
        polygonPath.closePath()
        
        
        return polygonPath
    }
}


// implementation of a stack data structure to hold forces
class Stack<T>{
    var data: Array<T> = []
    
    func items() -> Int{
        return data.count
    }
    
    func isEmpty() -> Bool{
        return data.count == 0
    }
    
    func push(value: T) -> Void{
        data.append(value)
    }
    
    func pop() -> T?{
        if !self.isEmpty(){
            let tmp: T = data.last!
            data.removeLast()
            return tmp
        } else {
            return nil
        }
    }
}

class Vector{
    
    var i: Double
    var j: Double
    var identifier: UInt32
    
    var magnitude: Double {
        get {
            return sqrt( self.i*self.i + self.j*self.j )
        }
    }
    
    // let gravity: Vector = Vector(0,-9.8)
    init (_ iVal: Double, _ jVal: Double, identifier bitmask: UInt32){
        // i units (x axis)
        i = iVal
        
        // j units (y axis)
        j = jVal
        
        // set bitmask identifier
        identifier = bitmask
    }
    
    // returns angle from x axis
    func angle() -> Double{
        let artan: Double = self.j / self.i
        return atan(artan)
    }
    
    // return CGVector with Vector's properties
    func cgVector() -> CGVector{
        return CGVector(dx: CGFloat(self.i), dy: CGFloat(self.j))
    }
}

class Force: Vector{
    
    // creates SKShapeNode which is sized relative to a CGFrame
    func shapeNode(x: CGFloat, y: CGFloat) -> SKShapeNode{
        let color = FBColors.Red
        let tailWidth: CGFloat = CGFloat(15)
        let headWidth: CGFloat = 2 * tailWidth

        let path: UIBezierPath = UIBezierPath.arrowPath(CGFloat(magnitude * 25), tailWidth: tailWidth, headWidth: headWidth)
        
        let shape: SKShapeNode = SKShapeNode()
        shape.path = path.CGPath
        shape.fillColor = color
        shape.strokeColor = color
        
        return shape
    }
}

class Velocity: Vector{
    
    // creates SKShapeNode which is sized relative to a CGFrame
    func shapeNode(x: CGFloat, y: CGFloat) -> SKShapeNode{
        let color = FBColors.Green
        let tailWidth: CGFloat = CGFloat(6)
        let headWidth: CGFloat = 2.5 * tailWidth
        
        let path: UIBezierPath = UIBezierPath.arrowPath(CGFloat(magnitude * 10), tailWidth: tailWidth, headWidth: headWidth)
        
        let shape: SKShapeNode = SKShapeNode()
        shape.path = path.CGPath
        shape.fillColor = color
        shape.strokeColor = color
        
        return shape
    }
}