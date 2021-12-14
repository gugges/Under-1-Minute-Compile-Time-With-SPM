
import Foundation

public protocol ExperimentInterface {
    func isActive(experiment: Experiment) -> Bool
    func set(active: Bool, experiment: Experiment)
    func set(experiments: [Experiment: Bool])
}

public enum Experiment {
    case newPhysicsExperience
}
