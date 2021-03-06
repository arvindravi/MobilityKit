import HealthKit

public class MobilityKit {
    
    public let shared: MobilityKit = MobilityKit()
    
    private let store: HKHealthStore
    private let typesToRead: Set = [
        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!
    ]
    
    private init(store: HKHealthStore = HKHealthStore()) {
        self.store = store
    }
    
    func requestAuthorization() {
        store.requestAuthorization(toShare: nil,
                                   read: typesToRead) { (success, error) in
            if !success, let error = error {
                print("Authorization Failed: \(error.localizedDescription)")
            }
        }
    }
    
    func walkingSpeedSamples(_ completion: @escaping () -> Void) {
        let start = Calendar.current.date(byAdding: .day, value: -30, to: .init())
        let end = Calendar.current.date(byAdding: .day, value: 60, to: .init())
        
        let datePredicate = HKQuery.predicateForSamples(withStart: start, end: end, options: [])
        
        // Query Walking Speeds
        let walkSpeedType = HKSampleType.quantityType(forIdentifier: .walkingSpeed)!
        let sortByStartDate = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        let query = HKSampleQuery(sampleType: walkSpeedType,
                                  predicate: datePredicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: [sortByStartDate]) { (_, samples, error) in
            print(samples)
        }
        
        store.execute(query)
    }
    
}
