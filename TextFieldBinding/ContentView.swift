//
//  ContentView.swift
//  TextFieldBinding
//
//  Created by Georgi Ivanov on 30.07.22.
//

import SwiftUI
import ComposableArchitecture

struct ContentState: Equatable {
    @BindableState var text: String = ""
}

enum ContentAction: Equatable, BindableAction {
    case binding(BindingAction<ContentState>)
}

struct Environment {
    
}

let reducer = Reducer<
    ContentState,
    ContentAction,
    Environment
> { state, action, env in
    switch action {
    case .binding:
        print("Text:", state.text)
        return .none
    }
}
.binding()

let store = Store(
    initialState: ContentState(),
    reducer: reducer,
    environment: Environment()
)

struct ContentView: View {
    let store: Store<ContentState, ContentAction>
    
    init(store: Store<ContentState, ContentAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                TextField(
                    "",
                    text: viewStore.binding(\.$text)
                    // Try regular binding
//                    text: .init(get: { "Hello" }, set: { newValue in
//                        print(newValue)
//                    })
                )
                .background(Color.gray.opacity(0.4))
                
                Text("Enter some text")
                    .padding()
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: store)
    }
}
