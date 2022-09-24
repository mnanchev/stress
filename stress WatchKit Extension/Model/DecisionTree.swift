//
//  DecisionTree.swift
//  stress WatchKit Extension
//
//  Created by Martin Nanchev on 4.06.22.
//
import Foundation
class DesicionTree {
    private var sdnn: Double
    private var rmssd: Double
    init(sdnn: Double){
        self.sdnn = sdnn
        self.rmssd = 0.0
    }
    
    public func getRmssd() -> Int {
        return Int(round(self.rmssd))
    }
    private func setRmssd(value: Double){
        self.rmssd = Double(round(100 * value) / 100)
    }
    private func step_function(value: Double) -> Double{
        setRmssd(value: (1021.6*pow(value,-1.068)-0.867))
        let value = value/80
        return value > 1.0 ? 100.0 : value*100
    }
    public func getStressLevel() -> Int {
        let value: Double = round(pow(((sdnn+0.986)/879.978), (1/(-1.017))))
        return Int(round(self.step_function(value: value)))
    }
}
