import SwiftUI
import HealthKit

struct ContentView: View {
    // MARK: - PROPERTY
    private var healthStore = HKHealthStore()
    let heartRateVariability = HKUnit(from: "ms")
    
    let color = [
        "darkBlue": Color(red: 0.193, green: 0.360, blue: 0.749),
        "lightBlue": Color(red: 0.642, green: 0.788, blue: 1.0),
        "lighterBlue": Color.accentColor,
        "lightOrange": Color(red: 0.977, green: 0.813, blue: 0.403),
        "darkOrange": Color(red: 0.972, green: 0.300, blue: 0.203)
    ]
    @State private var value:Int = 0
    @State private var rmssd:Int = 0
    @State private var minValue = "0"
    @State private var maxValue = "100"
    @State private var lfHf = 0.0
    // MARK: - BODY
    var body: some View {
        let gradient = Gradient(colors: [color["darkBlue"]!, color["lightBlue"]!, color["lightOrange"]!, color["darkOrange"]!])
        
        VStack{
            HStack{
                Text("Stress lvl")
                    .font(.system(size: 23)).foregroundColor(Color.accentColor)
                    .fontWeight(.light)
                Spacer()
                
            }
            HStack{
                Text("lf/hf: \(String(format: "%.2f", lfHf))  rmssd: \(rmssd)")
                    .font(.system(size: 20)).foregroundColor(Color.accentColor)
                    .fontWeight(.light)
                Spacer()
                
            }
            Gauge(value: Double(value), in: 0...100) {
                Image(systemName: "drop.fill")
                    .foregroundColor(.red)
            } currentValueLabel: {
                
                Text("\(value)").fontWeight(.light)
                    .foregroundColor(value < 50 ?  color["lightBlue"] : value < 80 ?  color["lightOrange"]: color["darkOrange"])
            } minimumValueLabel: {
                Text(minValue)
                    .foregroundColor(Color.accentColor).fontWeight(.light)
            } maximumValueLabel: {
                Text(maxValue)
                    .foregroundColor(color["darkOrange"]).fontWeight(.light)
            }
            .scaleEffect(2.6)
            .gaugeStyle(CircularGaugeStyle(tint: gradient)).frame(alignment:Alignment.center).padding(.top, 45.0)
            
        }
        .onAppear(perform: start)
    }
    
    // MARK: - FUNCTION
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRateVariabilitySDNN)
    }
    
    func autorizeHealthKit() {
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)!]
        
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // 1
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        // 2
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // 3
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
            
        }
        
        // 4
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // 5
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var result = 0.0
        var rmssd = 0.0
        var lastHeartRateVariability = 0.0
        for sample in samples {
            if type == .heartRateVariabilitySDNN {
                lastHeartRateVariability = sample.quantity.doubleValue(for: heartRateVariability)
                let decisionTree = DesicionTree(sdnn: lastHeartRateVariability)
                result = Double(decisionTree.getStressLevel())
                rmssd = Double(decisionTree.getRmssd())
            }
            self.value = Int(result)
            self.rmssd = Int(rmssd)
            self.lfHf = (lastHeartRateVariability/Double(self.rmssd))/0.0941 - 1.593
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
