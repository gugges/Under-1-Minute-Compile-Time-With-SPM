
import Interfaces
import SwiftUI

struct SettingsView: View {
    
    private let interfaces: Interfaces?

    // MARK: - Init
    
    init(interfaces: Interfaces?) {
        self.interfaces = interfaces
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()

                makePhysicsButton()
                
                Spacer()
                    .frame(height: 30)
                                    
                makeSignOutButton()
                
                Spacer()
            }
        }
    }

    private func makePhysicsButton() -> some View {
        Button {
            togglePhysicsExperiment()

        } label: {
            VStack {
                Image(systemName: "atom")
                    .font(Font.system(size: 40, weight: .light))
                    .foregroundColor(Color.white)
                Spacer()
                    .frame(height: 6)
                Text("Toggle Physics Experiment")
                    .font(.title2)
                    .foregroundColor(Color.white)
            }
            .padding()
            .frame(width: 300)
            .background(Color.purple)
            .cornerRadius(4)
        }
    }

    private func makeSignOutButton() -> some View {
        Button {
            signOut()

        } label: {
            VStack {
                 Text("Sign out")
                     .font(.title2)
                     .foregroundColor(Color.white)
             }
             .padding()
             .frame(width: 300)
             .background(Color.blue)
             .cornerRadius(4)
        }
    }

    // MARK: - Actions
    
    private func togglePhysicsExperiment() {
        guard let interfaces = interfaces else { return }
        
        interfaces.logInterface.debug("Toggled Physics Experiment, now reloading")
        
        let isNewPhysicsActive: Bool = interfaces.experimentInterface.isActive(experiment: .newPhysicsExperience)
        interfaces.experimentInterface.set(active: !isNewPhysicsActive, experiment: .newPhysicsExperience)
        
        
        // This is a hack to reload the sample app back to the signed in state
        interfaces.bootstrapInterface.set(accessToken: nil)
        interfaces.bootstrapInterface.fetchBootstrap()
        interfaces.bootstrapInterface.set(accessToken: "Token123")
    }
    
    private func signOut() {
        interfaces?.logInterface.debug("Sign out button tapped")
        interfaces?.bootstrapInterface.set(accessToken: nil)
        interfaces?.bootstrapInterface.fetchBootstrap()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(interfaces: nil)
    }
}
