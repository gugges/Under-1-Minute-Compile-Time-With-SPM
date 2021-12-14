
import Foundation
import Interfaces

public final class ConcreteExperimentInterface: ExperimentInterface {
    
    private var experiments: [Experiment: Bool]
    
    public init(experiments: [Experiment: Bool]) {
        self.experiments = experiments
    }
    
    public func isActive(experiment: Experiment) -> Bool {
        return experiments[experiment] ?? false
    }
    
    public func set(active: Bool, experiment: Experiment) {
        experiments[experiment] = active
    }
    
    public func set(experiments: [Experiment: Bool]) {
        self.experiments = experiments
    }
    
}
