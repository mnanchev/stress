//
//  DecisionTree.swift
//  stress WatchKit Extension
//
//  Created by Martin Nanchev on 4.06.22.
//
import Foundation
class DesicionTree {
    private var sdnn: Double
    init(sdnn: Double){
        self.sdnn = sdnn
    }
    private func step_function(value: Double) -> Double{
        let value = value/80
        return value > 1.0 ? 100.0 : value*100
    }
    public func getStressLevel() -> Int {
        let value: Double = round(pow(((sdnn+0.986)/879.978), (1/(-1.017))))
        return Int(round(self.step_function(value: value)))
    }
}
