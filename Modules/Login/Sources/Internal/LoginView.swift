
import Interfaces
import SwiftUI

struct LoginView: View {
    
    private let interfaces: Interfaces?
    private let onLoginSuccess: (_ accessToken: String) -> Void
    
    // MARK: - Init
    
    init(interfaces: Interfaces?,
         onLoginSuccess: @escaping (_ accessToken: String) -> Void) {
        self.interfaces = interfaces
        self.onLoginSuccess = onLoginSuccess
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack(alignment: .center, spacing: 36) {
                if #available(iOS 15.0, *) {
                    LinearGradient(gradient:
                                    Gradient(colors: [
                                        Color("Swift-Logo-Top", bundle: .module),
                                        Color("Swift-Logo-Bottom", bundle: .module)
                                    ]),
                                   startPoint: .init(x: 0.25, y: 0.25),
                                   endPoint: .bottomTrailing)
                        .mask {
                            Image(systemName: "swift")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 200,
                               height: 200,
                               alignment: .center)
                } else {
                    Image(systemName: "swift")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200,
                               height: 200,
                               alignment: .center)
                        .foregroundColor(Color("Swift-Logo-Bottom", bundle: .module))
                }
                
                Text("Swift Package Manager Modules")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                
                Text("Demo App")
                    .font(.title)
                    .foregroundColor(.gray)
                
                Spacer()
  
                Button {
                    interfaces?.logInterface.debug("Sign In Button Tapped")
                    
                    // Here you would display an email/password login prompt
                    // The networking could validate the user and fetch an access token
                    // that token you could pass back to bootstrap for the next state update
                    onLoginSuccess("AccessToken")

                } label: {
                    Text("Sign in")
                          .font(.title2)
                          .foregroundColor(Color.white)
                          .padding()
                          .frame(width: 300)
                          .background(Color.blue)
                          .cornerRadius(4)
                }
            }
            .padding()
        }
        .background(Color.black)
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(interfaces: nil) { accessToken in }
    }
}
